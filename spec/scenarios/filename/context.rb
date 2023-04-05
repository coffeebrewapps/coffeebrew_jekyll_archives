# frozen_string_literal: true

CONTEXT_FILENAME = "when using different filename configs"

RSpec.shared_context CONTEXT_FILENAME do
  let(:scenario) { "filename" }
  let(:overrides) do
    {
      "archives" => {
        "root" => "/blog/chronicles.html",
        "navigation" => {
          "name" => "Chronicles"
        },
        "root_dir" => "/blog",
        "root_basename" => "chronicles",
        "index_root" => "/chronicles",
        "index_basename" => "page"
      }
    }
  end
  let(:generated_files) { Dir[dest_dir("blog", "chronicles.html"), dest_dir("blog", "chronicles", "**", "*.html")] }
  let(:expected_files) do
    [
      # Main index
      dest_dir("blog", "chronicles.html"),

      # Year indexes
      dest_dir("blog", "chronicles", "2021",  "page.html"),
      dest_dir("blog", "chronicles", "2022",  "page.html"),
      dest_dir("blog", "chronicles", "2023",  "page.html"),

      # Month indexes
      dest_dir("blog", "chronicles", "2021", "03", "page.html"),
      dest_dir("blog", "chronicles", "2021", "05", "page.html"),
      dest_dir("blog", "chronicles", "2022", "01", "page.html"),
      dest_dir("blog", "chronicles", "2022", "03", "page.html"),
      dest_dir("blog", "chronicles", "2022", "11", "page.html"),
      dest_dir("blog", "chronicles", "2023", "02",  "page.html"),

      # Day indexes
      dest_dir("blog", "chronicles", "2021", "03", "12", "page.html"),
      dest_dir("blog", "chronicles", "2021", "03", "28", "page.html"),
      dest_dir("blog", "chronicles", "2021", "05", "03", "page.html"),
      dest_dir("blog", "chronicles", "2022", "01", "27", "page.html"),
      dest_dir("blog", "chronicles", "2022", "03", "12", "page.html"),
      dest_dir("blog", "chronicles", "2022", "11", "23", "page.html"),
      dest_dir("blog", "chronicles", "2023", "02", "21", "page.html"),
    ]
  end
end
