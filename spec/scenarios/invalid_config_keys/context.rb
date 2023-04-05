# frozen_string_literal: true

CONTEXT_INVALID_CONFIG_KEYS = "when using invalid config keys"

RSpec.shared_context CONTEXT_INVALID_CONFIG_KEYS do
  let(:scenario) { "invalid_config_keys" }
  let(:generated_files) { [] }
  let(:expected_files) { [] }
  let(:overrides) do
    {
      "archives" => {
        "invalid" => "key",
        "navigation" => {
          "invalid" => "navigation_key"
        },
        "title_format" => {
          "invalid" => "nested_key",
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
        },
        "permalink" => {
          "invalid" => "key"
        }
      }
    }
  end

  let(:expected_errors) do
    [
      { key: "archives.invalid", expected: nil, got: "key" },
      { key: "archives.navigation.invalid", expected: nil, got: "navigation_key" },
      { key: "archives.title_format.invalid", expected: nil, got: "nested_key" },
      { key: "archives.title_format.root.invalid", expected: nil, got: "nested_key" },
      { key: "archives.title_format.year.invalid", expected: nil, got: "nested_key" },
      { key: "archives.title_format.month.invalid", expected: nil, got: "nested_key" },
      { key: "archives.title_format.day.invalid", expected: nil, got: "nested_key" },
      { key: "archives.permalink.invalid", expected: nil, got: "key" },
    ]
  end
end
