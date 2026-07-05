require_relative "../empty_typescript_react_project_generator"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      module Generators
        class RobotsTxtGenerator < EmptyTypescriptReactProjectGenerator
          def template_path = ["public", "robots.txt.erb"]
        end
      end
    end
  end
end
