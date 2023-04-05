# frozen_string_literal: true

CONTEXT_PERMALINK = "when using different permalink configs"

RSpec.shared_context CONTEXT_PERMALINK do
  let(:scenario) { "permalink" }
  let(:overrides) do
    {
      "archives" => {
        "permalink" => {
          "root" => "/:root_dir/:index_root",
          "year" => "/:root_dir/:year",
          "month" => "/:root_dir/:year/:month",
          "day" => "/:root_dir/:year/:month/:day"
        }
      }
    }
  end
  let(:generated_files) { Dir[dest_dir("archives", "archives.html"), dest_dir("**", "index.html")] }
  let(:expected_files) do
    [
      # Main index
      dest_dir("archives", "archives.html"),

      # Year indexes
      dest_dir("2021",  "index.html"),
      dest_dir("2022",  "index.html"),
      dest_dir("2023",  "index.html"),

      # Month indexes
      dest_dir("2021", "03", "index.html"),
      dest_dir("2021", "05", "index.html"),
      dest_dir("2022", "01", "index.html"),
      dest_dir("2022", "03", "index.html"),
      dest_dir("2022", "11", "index.html"),
      dest_dir("2023", "02",  "index.html"),

      # Day indexes
      dest_dir("2021", "03", "12", "index.html"),
      dest_dir("2021", "03", "28", "index.html"),
      dest_dir("2021", "05", "03", "index.html"),
      dest_dir("2022", "01", "27", "index.html"),
      dest_dir("2022", "03", "12", "index.html"),
      dest_dir("2022", "11", "23", "index.html"),
      dest_dir("2023", "02", "21", "index.html"),
    ]
  end
end
