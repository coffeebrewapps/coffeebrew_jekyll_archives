# frozen_string_literal: true

CONTEXT_DEPTH_ONE = "when using depths=1"

RSpec.shared_context CONTEXT_DEPTH_ONE do
  let(:scenario) { "depth_one" }
  let(:expected_files) do
    [
      # Main index
      dest_dir("archives.html"),

      # Year indexes
      dest_dir("archives", "2021",  "index.html"),
      dest_dir("archives", "2022",  "index.html"),
      dest_dir("archives", "2023",  "index.html"),
    ]
  end
end
