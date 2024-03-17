require "English"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class EmptyTypescriptReactProjectConfig < Foobara::Model
        attributes do
          project_dir :string, :required
        end
      end
    end
  end
end
