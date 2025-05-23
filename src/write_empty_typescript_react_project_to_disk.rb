require_relative "generate_empty_typescript_react_project"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class WriteEmptyTypescriptReactProjectToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "typescript-react-project"
          end
        end

        depends_on GenerateEmptyTypescriptReactProject

        inputs do
          empty_typescript_react_project_config EmptyTypescriptReactProjectConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string, default: "."
        end

        def execute
          run_pre_generation_tasks
          generate_file_contents
          write_all_files_to_disk
          run_post_generation_tasks

          stats
        end

        # A bit confusing... we need to write the files to the output_directory/project_dir
        # and the code that writes the generated files assumes that output_directory contains the place
        # to write the files not the place to initiate the project
        def output_directory
          project_directory
        end

        def output_parent_directory
          inputs[:output_directory]
        end

        def project_directory
          path = "#{output_parent_directory}/#{empty_typescript_react_project_config.project_dir}"

          Pathname.new(path).realpath.to_s
        end

        def push_to_github?
          empty_typescript_react_project_config.push_to_github
        end

        def generate_file_contents
          self.paths_to_source_code = run_subcommand!(GenerateEmptyTypescriptReactProject,
                                                      empty_typescript_react_project_config.attributes)
        end

        def run_pre_generation_tasks
          run_npx_create_react_app
          add_necessary_dev_dependencies_for_eslint
          fix_uncorrectable_lint_violations
          eslint_fix
          git_init
          git_add_all
          git_commit_lint_fixes
        end

        def run_npx_create_react_app
          puts "created empty project with create-react-app..."

          cmd = "npx create-react-app --template typescript #{empty_typescript_react_project_config.project_dir}"

          FileUtils.mkdir_p output_parent_directory

          Dir.chdir output_parent_directory do
            run_cmd_and_write_output(cmd)
          end
        end

        def add_necessary_dev_dependencies_for_eslint
          puts "adding dependencies needed for linter to actually work..."

          cmd = "npm install --save-dev " \
                "@babel/plugin-proposal-private-property-in-object@^7.21.11 " \
                "@eslint/create-config@^0.4.6 " \
                "eslint-config-standard-with-typescript@^37.0.0 " \
                "eslint-plugin-n@^16.5.0 " \
                "eslint-plugin-promise@^6.1.1 " \
                "typescript@^4.0.0 "

          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd)
          end
        end

        def run_post_generation_tasks
          eslint_fix
          git_add_all
          git_commit_generated_files
          git_branch_main

          if push_to_github?
            gh_repo_create
            git_add_remote_origin
            push_to_github
          end
        end

        def fix_uncorrectable_lint_violations
          Dir.chdir(project_directory) do
            web_vitals_contents = File.read("src/reportWebVitals.ts")
            web_vitals_contents.gsub!("if (onPerfEntry && ", "if (onPerfEntry != null && ")
            File.write("src/reportWebVitals.ts", web_vitals_contents)
          end
        end

        def eslint_fix
          puts "linting..."

          cmd = "npx eslint 'src/**/*.{js,jsx,ts,tsx}' --fix"
          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd)
          end
        end

        def git_init
          cmd = "git init"

          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd)
          end
        end

        def git_add_all
          cmd = "git add ."

          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd)
          end
        end

        def git_commit_lint_fixes
          cmd = "git commit -m 'Make project work with eslint and eslint --fix everything'"

          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd, raise_if_fails: false)
          end
        end

        def git_commit_generated_files
          cmd = "git commit -m 'Generate additional files to make things work with Foobara'"

          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd, raise_if_fails: false)
          end
        end

        def git_repo_path
          org = empty_typescript_react_project_config.github_organization ||
                File.basename(File.dirname(project_directory.to_s))
          "#{org}/#{empty_typescript_react_project_config.project_dir}"
        end

        attr_accessor :push_to_github_failed

        def push_to_github_failed?
          push_to_github_failed
        end

        def gh_repo_create
          return if push_to_github_failed?

          cmd = "gh repo create --private --push --source=. #{git_repo_path}"

          Dir.chdir project_directory do
            exit_status = run_cmd_and_write_output(cmd, raise_if_fails: false)

            unless exit_status&.success?
              self.push_to_github_failed = true
            end
          end
        end

        def git_add_remote_origin
          return if push_to_github_failed?

          git_remote_cmd = "git remote"
          git_remote_add_cmd = "git remote add origin git@github.com:#{git_repo_path}.git"

          Dir.chdir project_directory do
            remotes = run_cmd_and_return_output(git_remote_cmd)

            if remotes !~ /^origin$/
              exit_status = run_cmd_and_write_output(git_remote_add_cmd)

              unless exit_status&.success?
                # :nocov:
                self.push_to_github_failed = true
                # :nocov:
              end
            end
          end
        rescue CouldNotExecuteError => e
          # :nocov:
          self.push_to_github_failed = true
          warn e.message
          # :nocov:
        end

        def git_branch_main
          cmd = "git branch -M main"

          Dir.chdir project_directory do
            run_cmd_and_write_output(cmd)
          end
        end

        def push_to_github
          cmd = "git push -u origin main"

          Dir.chdir project_directory do
            exit_status = run_cmd_and_write_output(cmd, raise_if_fails: false)

            unless exit_status&.success?
              self.push_to_github_failed = true
            end
          end
        end
      end
    end
  end
end
