require "English"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      class EmptyTypescriptReactProjectConfig < Foobara::Model
        attributes do
          project_dir :string, :required
          github_organization :string
          push_to_github :boolean, default: false
          site_url :string, default: "https://example.com"
        end
      end
    end
  end
end
