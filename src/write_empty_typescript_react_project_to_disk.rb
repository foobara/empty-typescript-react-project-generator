require_relative "generate_empty_typescript_react_project"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class WriteEmptyTypescriptReactProjectToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "empty_typescript_react_project"
          end
        end

        depends_on GenerateEmptyTypescriptReactProject

        inputs do
          empty_typescript_react_project_config EmptyTypescriptReactProjectConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
          run_pre_generation_tasks
          generate_file_contents
          write_all_files_to_disk
          run_post_generation_tasks

          stats
        end

        def output_directory
          inputs[:output_directory] || default_output_directory
        end

        def default_output_directory
          "."
        end

        def generate_file_contents
          self.paths_to_source_code = run_subcommand!(GenerateEmptyTypescriptReactProject,
                                                      empty_typescript_react_project_config.attributes)
        end

        def run_pre_generation_tasks
          run_npx_create_react_app
          add_necessary_dev_dependencies_for_eslint
        end

        def run_npx_create_react_app
          puts "created empty project with create-react-app..."

          Dir.chdir output_directory do
            cmd = "npx create-react-app --template typescript whatever-frontend"
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

          run_cmd_and_write_output(cmd)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            eslint_fix
          end
        end

        def eslint_fix
          cmd = "npx eslint 'src/**/*.{js,jsx,ts,tsx}' --fix"
          run_cmd_and_write_output(cmd)
        end
      end
    end
  end
end
