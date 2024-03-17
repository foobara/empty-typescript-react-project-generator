require "pathname"

require_relative "empty_typescript_react_project_config"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class GenerateEmptyTypescriptReactProject < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs EmptyTypescriptReactProjectConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::EmptyTypescriptReactProjectGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << empty_typescript_react_project_config
        end

        def empty_typescript_react_project_config
          @empty_typescript_react_project_config ||= EmptyTypescriptReactProjectConfig.new(inputs)
        end
      end
    end
  end
end
