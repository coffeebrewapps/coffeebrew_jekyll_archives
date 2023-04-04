# frozen_string_literal: true

require "spec_helper"

SUCCESS_EXAMPLE = "generates a page for each depth of posts with correct navigation and link hierarchy"
FAILURE_EXAMPLE = "raises Jekyll::Errors::InvalidConfigurationError"

RSpec.describe(Coffeebrew::Jekyll::Archives) do
  let(:overrides) { {} }
  let(:config) do
    Jekyll.configuration(
      Jekyll::Utils.deep_merge_hashes(
        {
          "full_rebuild" => true,
          "source" => source_dir,
          "destination" => dest_dir,
          "show_drafts" => false,
          "url" => "https://coffeebrew-jekyll-archives.com",
          "name" => "CoffeeBrewApps Jekyll Archives",
          "author" => {
            "name" => "Coffee Brew Apps"
          },
          "collections" => {}
        },
        overrides
      )
    )
  end

  let(:site)            { Jekyll::Site.new(config) }
  let(:generated_files) { Dir[dest_dir("archives.html"), dest_dir("archives", "**", "*.html")] }

  after do
    FileUtils.rm_r(dest_dir, force: true)
  end

  context "with success examples" do
    shared_examples_for SUCCESS_EXAMPLE do
      it do
        site.process
        expect(generated_files).to match_array(expected_files)
        generated_files.each do |generated_file|
          expected_file = generated_file.gsub(DEST_DIR, File.join(SCENARIO_DIR, scenario, "_site"))
          sanitized_generated = sanitize_html(File.read(generated_file))
          sanitized_expected = sanitize_html(File.read(expected_file))
          expect(sanitized_generated).to eq sanitized_expected
        end
      end
    end
  end

  context "with failure examples" do
    before do
      allow(Jekyll.logger).to receive(:error)
    end

    shared_examples_for FAILURE_EXAMPLE do
      it do
        site.process
      rescue Jekyll::Errors::InvalidConfigurationError => e
        expect(e.message).to eq "'archives' config is set incorrectly."
        expect(generated_files).to be_empty
        expect(Jekyll.logger).to have_received(:error).with("'archives' config is set incorrectly.").once
        expect(Jekyll.logger).to have_received(:error).with("Errors:", match_array(expected_errors)).once
      end
    end
  end
end
