require_relative "generate_organization"

module Foobara
  module Generators
    module OrganizationGenerator
      class WriteOrganizationToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "organization"
          end
        end

        depends_on GenerateOrganization

        inputs do
          organization_config OrganizationConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
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
          # TODO: just pass this in as the inputs instead of the organization??
          self.paths_to_source_code = run_subcommand!(GenerateOrganization, organization_config.attributes)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            rubocop_autocorrect
          end
        end

        def rubocop_autocorrect
          # :nocov:
          Open3.popen3("bundle exec rubocop --no-server -A") do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            unless exit_status.success?
              raise "could not rubocop -A. #{stderr.read}"
            end
          end
          # :nocov:
        end
      end
    end
  end
end
