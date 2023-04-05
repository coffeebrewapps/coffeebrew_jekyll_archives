# frozen_string_literal: true

CONTEXT_BEFORE_NAVIGATION = "when navigation is set to before an existing item"

RSpec.shared_context CONTEXT_BEFORE_NAVIGATION do
  let(:scenario) { "before_navigation" }
  let(:overrides) do
    {
      "archives" => {
        "navigation" => {
          "before" => "Projects"
        }
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

      # Day indexes
      dest_dir("archives", "2021", "03", "12", "index.html"),
      dest_dir("archives", "2021", "03", "28", "index.html"),
      dest_dir("archives", "2021", "05", "03", "index.html"),
      dest_dir("archives", "2022", "01", "27", "index.html"),
      dest_dir("archives", "2022", "03", "12", "index.html"),
      dest_dir("archives", "2022", "11", "23", "index.html"),
      dest_dir("archives", "2023", "02", "21", "index.html"),
    ]
  end
end
