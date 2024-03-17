require_relative "src/version"

Gem::Specification.new do |spec|
  spec.name = "foobara-empty-typescript-react-project-generator"
  spec.version = Foobara::Generators::EmptyTypescriptReactProjectGenerator::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "Generates empty typescript react projects"
  spec.homepage = "https://github.com/foobara/generators-empty-typescript-react-project-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE.txt"
  ]

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
