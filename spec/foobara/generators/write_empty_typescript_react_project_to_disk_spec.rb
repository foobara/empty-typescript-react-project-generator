RSpec.describe Foobara::Generators::EmptyTypescriptReactProjectGenerator::WriteEmptyTypescriptReactProjectToDisk do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { empty_typescript_react_project.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      empty_typescript_react_project_config:,
      output_directory:
    }
  end
  let(:empty_typescript_react_project_config) do
    {
      project_dir:,
      description: "whatever"
    }
  end
  let(:project_dir) { "SomeOrg" }
  let(:output_directory) { "#{__dir__}/../../../tmp/empty_typescript_react_project_test_suite_output" }

  before do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(described_class).to receive(:git_commit).and_return(nil)
    allow_any_instance_of(described_class).to receive(:rubocop_autocorrect).and_return(nil)
    # rubocop:enable RSpec/AnyInstance
    FileUtils.rm_rf output_directory
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(command.paths_to_source_code.keys).to include("src/some_org.rb")
    end
  end

  describe "#output_directory" do
    context "with no output directory" do
      let(:inputs) do
        {
          empty_typescript_react_project_config:
        }
      end

      it "writes files to the current directory" do
        command.cast_and_validate_inputs
        expect(command.output_directory).to eq(".")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
