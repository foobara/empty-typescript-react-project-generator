module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      module Generators
        class EmptyTypescriptReactProjectGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when EmptyTypescriptReactProjectConfig
                [
                  Generators::EmptyTypescriptReactProjectGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          def template_path
            ["src", "organization.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, file]
          end

          alias empty_typescript_react_project_config relevant_manifest

          def templates_dir
            "#{__dir__}/../templates"
          end
        end
      end
    end
  end
end
