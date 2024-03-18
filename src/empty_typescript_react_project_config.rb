require "English"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class EmptyTypescriptReactProjectConfig < Foobara::Model
        attributes do
          project_dir :string, :required
          github_organization :string
        end
      end
    end
  end
end
