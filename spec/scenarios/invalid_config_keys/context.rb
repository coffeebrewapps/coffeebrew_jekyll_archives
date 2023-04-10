# frozen_string_literal: true

CONTEXT_INVALID_CONFIG_KEYS = "when using invalid config keys"

RSpec.shared_context CONTEXT_INVALID_CONFIG_KEYS do
  let(:scenario) { "invalid_config_keys" }
  let(:generated_files) { [] }
  let(:expected_files) { [] }
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
