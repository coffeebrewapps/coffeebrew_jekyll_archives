# frozen_string_literal: true

require "spec_helper"

require_relative "./scenarios/default/context"
require_relative "./scenarios/before_navigation/context"
require_relative "./scenarios/after_navigation/context"
require_relative "./scenarios/depth_one/context"
require_relative "./scenarios/depth_two/context"
require_relative "./scenarios/title_format/context"
require_relative "./scenarios/filename/context"
require_relative "./scenarios/permalink/context"

require_relative "./scenarios/invalid_config_values/context"
require_relative "./scenarios/invalid_config_keys/context"

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

    context CONTEXT_DEFAULT do
      include_context CONTEXT_DEFAULT do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_BEFORE_NAVIGATION do
      include_context CONTEXT_BEFORE_NAVIGATION do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_AFTER_NAVIGATION do
      include_context CONTEXT_AFTER_NAVIGATION do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_DEPTH_ONE do
      include_context CONTEXT_DEPTH_ONE do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_DEPTH_TWO do
      include_context CONTEXT_DEPTH_TWO do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_TITLE_FORMAT do
      include_context CONTEXT_TITLE_FORMAT do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_FILENAME do
      include_context CONTEXT_FILENAME do
        it_behaves_like SUCCESS_EXAMPLE
      end
    end

    context CONTEXT_PERMALINK do
      include_context CONTEXT_PERMALINK do
        it_behaves_like SUCCESS_EXAMPLE
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

    context CONTEXT_INVALID_CONFIG_VALUES do
      include_context CONTEXT_INVALID_CONFIG_VALUES do
        it_behaves_like FAILURE_EXAMPLE
      end
    end

    context CONTEXT_INVALID_CONFIG_KEYS do
      include_context CONTEXT_INVALID_CONFIG_KEYS do
        it_behaves_like FAILURE_EXAMPLE
      end
    end
  end
end
