require_relative "version"

source "https://rubygems.org"
ruby Foobara::Generators::EmptyTypescriptReactProjectGenerator::MINIMUM_RUBY_VERSION

gemspec

# gem "foobara-util", path: "../util"
# gem "foobara-files-generator", path: "../files-generator"

gem "rake"

group :development do
  gem "foobara-rubocop-rules"
  gem "guard-rspec"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
end

group :test do
  gem "foobara-spec-helpers"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov"
end
