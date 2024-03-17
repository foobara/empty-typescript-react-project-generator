module Foobara
  module Generators
    module EmptyTypescriptReactProjectGenerator
      module Generators
        class EmptyTypescriptReactProjectGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when EmptyTypescriptReactProjectConfig
                # Nothing to do yet re: rendering templates. Everything is untemplated so far.
                []
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end
        end
      end
    end
  end
end
