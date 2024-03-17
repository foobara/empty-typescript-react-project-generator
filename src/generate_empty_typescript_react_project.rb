require "pathname"

require_relative "organization_config"

module Foobara
  module Generators
    module OrganizationGenerator
      class GenerateOrganization < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs OrganizationConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::OrganizationGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << organization_config
        end

        def organization_config
          @organization_config ||= OrganizationConfig.new(inputs)
        end
      end
    end
  end
end
