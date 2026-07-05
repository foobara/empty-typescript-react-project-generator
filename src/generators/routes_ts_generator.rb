require_relative "../empty_typescript_react_project_generator"

module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      module Generators
        class RoutesTsGenerator < EmptyTypescriptReactProjectGenerator
          def template_path = ["scripts", "routes.ts.erb"]
        end
      end
    end
  end
end
