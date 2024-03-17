RSpec.describe Foobara::Generators::EmptyTypescriptReactProjectGenerator::GenerateEmptyTypescriptReactProject do
  let(:project_dir) { "test-project" }

  let(:inputs) do
    {
      project_dir:
    }
  end
  let(:empty_typescript_react_project) { described_class.new(inputs) }
  let(:outcome) { empty_typescript_react_project.run }
  let(:result) { outcome.result }

  it "generates a empty_typescript_react_project" do
    expect(outcome).to be_success

    expect(result.keys).to contain_exactly("tsconfig.json", ".env", ".eslintrc.js")
  end
end
