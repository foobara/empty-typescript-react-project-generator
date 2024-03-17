require "English"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class EmptyTypescriptReactProjectConfig < Foobara::Model
        attributes do
          project_dir :string, :required
          description :string, :allow_nil
        end

        attr_accessor :module_path

        def initialize(attributes = nil, options = {})
          project_dir = attributes[:project_dir]
          description = attributes[:description]

          module_path = project_dir.split("::")

          super(
            {
              project_dir:,
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
