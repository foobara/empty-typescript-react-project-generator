RSpec.describe Foobara::Generators::OrganizationGenerator::GenerateOrganization do
  let(:organization_name) { "SomePrefix::SomeOrg" }

  let(:inputs) do
    {
      organization_name:,
      description: "whatever"
    }
  end
  let(:organization) { described_class.new(inputs) }
  let(:outcome) { organization.run }
  let(:result) { outcome.result }

  it "generates a organization" do
    expect(outcome).to be_success

    organization_file = result["src/some_prefix/some_org.rb"]
    expect(organization_file).to include("module SomeOrg")
    expect(organization_file).to include("module SomePrefix")
  end
end
