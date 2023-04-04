# frozen_string_literal: true

CONTEXT_INVALID_CONFIG_VALUES = "when using invalid config values"

RSpec.shared_context CONTEXT_INVALID_CONFIG_VALUES do
  let(:scenario) { "invalid_config_values" }
  let(:generated_files) { [] }
  let(:expected_files) { [] }
  let(:overrides) do
    {
      "archives" => {
        "navigation" => {
          "data" => {
            "invalid" => "navigation_data"
          },
          "name" => {
            "invalid" => "navigation_name"
          },
          "before" => {
            "invalid" => "navigation_before"
          },
          "after" => {
            "invalid" => "navigation_after"
          }
        },
        "depths" => "invalid",
        "title_format" => {
          "root" => {
            "type" => "invalid_type",
            "style" => {
              "invalid" => "style"
            }
          },
          "year" => {
            "type" => "invalid_type",
            "style" => {
              "invalid" => "style"
            }
          },
          "month" => {
            "type" => "invalid_type",
            "style" => {
              "invalid" => "style"
            }
          },
          "day" => {
            "type" => "invalid_type",
            "style" => {
              "invalid" => "style"
            }
          }
        },
        "root_dir" => {
          "invalid" => "nested_key"
        },
        "root_basename" => {
          "invalid" => "nested_key"
        },
        "index_root" => {
          "invalid" => "nested_key"
        },
        "index_basename" => {
          "invalid" => "nested_key"
        },
        "permalink" => {
          "root" => {
            "invalid" => "nested_key"
          },
          "year" => {
            "invalid" => "nested_key"
          },
          "month" => {
            "invalid" => "nested_key"
          },
          "day" => {
            "invalid" => "nested_key"
          }
        }
      }
    }
  end

  let(:expected_errors) do
    [
      { key: "archives.navigation.data", expected: [], got: { "invalid" => "navigation_data" } },
      { key: "archives.navigation.name", expected: [], got: { "invalid" => "navigation_name" } },
      { key: "archives.navigation.before", expected: [], got: { "invalid" => "navigation_before" } },
      { key: "archives.navigation.after", expected: [], got: { "invalid" => "navigation_after" } },

      { key: "archives.depths", expected: [1, 2, 3], got: "invalid" },

      { key: "archives.title_format.root.type", expected: ["string", "date"], got: "invalid_type" },
      { key: "archives.title_format.root.style", expected: [], got: { "invalid" => "style" } },
      { key: "archives.title_format.year.type", expected: ["string", "date"], got: "invalid_type" },
      { key: "archives.title_format.year.style", expected: [], got: { "invalid" => "style" } },
      { key: "archives.title_format.month.type", expected: ["string", "date"], got: "invalid_type" },
      { key: "archives.title_format.month.style", expected: [], got: { "invalid" => "style" } },
      { key: "archives.title_format.day.type", expected: ["string", "date"], got: "invalid_type" },
      { key: "archives.title_format.day.style", expected: [], got: { "invalid" => "style" } },

      { key: "archives.root_dir", expected: [], got: { "invalid" => "nested_key" } },
      { key: "archives.root_basename", expected: [], got: { "invalid" => "nested_key" } },
      { key: "archives.index_root", expected: [], got: { "invalid" => "nested_key" } },
      { key: "archives.index_basename", expected: [], got: { "invalid" => "nested_key" } },

      { key: "archives.permalink.root", expected: [], got: { "invalid" => "nested_key" } },
      { key: "archives.permalink.year", expected: [], got: { "invalid" => "nested_key" } },
      { key: "archives.permalink.month", expected: [], got: { "invalid" => "nested_key" } },
      { key: "archives.permalink.day", expected: [], got: { "invalid" => "nested_key" } },
    ]
  end
end
