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

    expect(result.keys).to contain_exactly(
      ".env",
      ".oxlintrc.json",
      ".github/workflows/tests.yml",
      "public/_redirects",
      "public/robots.txt",
      "scripts/generate-sitemap.ts",
      "scripts/prerender.ts",
      "scripts/routes.ts",
      "src/App.tsx",
      "src/main.tsx",
      "src/pages/About.tsx",
      "src/pages/Home.tsx",
      "src/pages/NotFound.tsx"
    )

    expect(result["public/robots.txt"]).to include("Sitemap: https://example.com/sitemap.xml")
    expect(result["scripts/routes.ts"]).to include("export const SITE_URL = 'https://example.com'")
  end

  context "when a site_url is given" do
    let(:inputs) do
      {
        project_dir:,
        site_url: "https://some-project.example.org"
      }
    end

    it "uses the site_url in the sitemap/robots.txt plumbing" do
      expect(outcome).to be_success

      expect(result["public/robots.txt"]).to include("Sitemap: https://some-project.example.org/sitemap.xml")
      expect(result["scripts/routes.ts"]).to include("export const SITE_URL = 'https://some-project.example.org'")
    end
  end
end
