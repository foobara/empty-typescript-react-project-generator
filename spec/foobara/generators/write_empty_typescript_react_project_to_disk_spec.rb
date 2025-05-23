RSpec.describe Foobara::Generators::EmptyTypescriptReactProjectGenerator::WriteEmptyTypescriptReactProjectToDisk do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
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
      push_to_github: true
    }
  end
  let(:project_dir) { "test-project" }
  let(:output_directory) { "#{__dir__}/../../../tmp/rspec-output" }

  before do
    # rubocop:disable RSpec/AnyInstance
    # Stubbing these to let more lines of the code be hit by the test suite
    allow_any_instance_of(described_class).to receive(:push_to_github_failed).and_return(nil)
    # rubocop:enable RSpec/AnyInstance

    FileUtils.rm_rf output_directory
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(File.exist?("#{output_directory}/#{project_dir}/.eslintrc.js")).to be(true)
      expect(File.exist?("#{output_directory}/#{project_dir}/.github/workflows/tests.yml")).to be(true)
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
        expect(command.output_parent_directory).to eq(".")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
