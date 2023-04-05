# frozen_string_literal: true

require "jekyll"
require File.expand_path("../lib/coffeebrew_jekyll_archives", __dir__)

Jekyll.logger.log_level = :error

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  SOURCE_DIR   = File.expand_path("fixtures",  __dir__)
  DEST_DIR     = File.expand_path("dest",      __dir__)
  SCENARIO_DIR = File.expand_path("scenarios", __dir__)

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end

  def expected_dir(*files)
    File.join(SCENARIO_DIR, *files)
  end

  def sanitize_html(content)
    content.split("\n").map do |line|
      no_indent = line.gsub(/^\s*/, "")
      no_indent = no_indent.strip.chomp
      no_indent.empty? ? nil : no_indent
    end.compact.join("")
  end
end
