require "English"

module Foobara
  module Generators
    module OrganizationGenerator
      class OrganizationConfig < Foobara::Model
        attributes do
          organization_name :string, :required
          description :string, :allow_nil
        end

        attr_accessor :module_path

        def initialize(attributes = nil, options = {})
          organization_name = attributes[:organization_name]
          description = attributes[:description]

          module_path = organization_name.split("::")

          super(
            {
              organization_name:,
              description:
            },
            options
          )

          self.module_path = module_path
        end
      end
    end
  end
end
