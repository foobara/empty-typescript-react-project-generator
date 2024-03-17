RSpec.describe Foobara::Generators::EmptyTypescriptReactProjectGenerator::GenerateEmptyTypescriptReactProject do
  let(:project_dir) { "SomePrefix::SomeOrg" }

  let(:inputs) do
    {
      project_dir:,
      description: "whatever"
    }
  end
  let(:empty_typescript_react_project) { described_class.new(inputs) }
  let(:outcome) { empty_typescript_react_project.run }
  let(:result) { outcome.result }

  it "generates a empty_typescript_react_project" do
    expect(outcome).to be_success

    empty_typescript_react_project_file = result["src/some_prefix/some_org.rb"]
    expect(empty_typescript_react_project_file).to include("module SomeOrg")
    expect(empty_typescript_react_project_file).to include("module SomePrefix")
  end
end
