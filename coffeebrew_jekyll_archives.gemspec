# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "coffeebrew_jekyll_archives/version"

Gem::Specification.new do |spec| # rubocop:disable Gemspec/RequireMFA
  spec.name          = "coffeebrew_jekyll_archives"
  spec.version       = Coffeebrew::Jekyll::Archives::VERSION
  spec.authors       = ["Coffee Brew Apps"]
  spec.email         = ["coffeebrewapps@gmail.com"]

  spec.summary       = "A Jekyll plugin to generate blog post archives"
  spec.description   = "A Jekyll plugin to generate blog post archives"
  spec.homepage      = "https://coffeebrewapps.com/coffeebrew_jekyll_archives"
  spec.license       = "MIT"

  raise "RubyGems 2.0 or newer is required to protect against public gem pushes." unless spec.respond_to?(:metadata)

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files            = Dir["lib/**/*.rb", "lib/**/*.yml"]
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE"]
  spec.require_paths    = ["lib/coffeebrew_jekyll_archives", "lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "jekyll", ">= 4.0", "< 5.0"
end
