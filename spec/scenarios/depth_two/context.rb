# frozen_string_literal: true

CONTEXT_DEPTH_TWO = "when using depths=2"

RSpec.shared_context CONTEXT_DEPTH_TWO do
  let(:scenario) { "depth_two" }
  let(:overrides) do
    {
      "archives" => {
        "depths" => 2
      }
    }
  end
  let(:expected_files) do
    [
      # Main index
      dest_dir("archives.html"),

      # Year indexes
      dest_dir("archives", "2021",  "index.html"),
      dest_dir("archives", "2022",  "index.html"),
      dest_dir("archives", "2023",  "index.html"),

      # Month indexes
      dest_dir("archives", "2021", "03", "index.html"),
      dest_dir("archives", "2021", "05", "index.html"),
      dest_dir("archives", "2022", "01", "index.html"),
      dest_dir("archives", "2022", "03", "index.html"),
      dest_dir("archives", "2022", "11", "index.html"),
      dest_dir("archives", "2023", "02", "index.html"),
    ]
  end
end
