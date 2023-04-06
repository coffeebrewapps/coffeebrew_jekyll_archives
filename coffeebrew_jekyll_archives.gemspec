# coding: utf-8
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "coffeebrew_jekyll_archives/version"

Gem::Specification.new do |spec|
  spec.name          = "coffeebrew_jekyll_archives"
  spec.version       = Coffeebrew::Jekyll::Archives::VERSION
  spec.authors       = ["Coffee Brew Apps"]
  spec.email         = ["coffeebrewapps@gmail.com"]

  spec.summary       = %q{A Jekyll plugin to generate blog post archives}
  spec.description   = %q{A Jekyll plugin to generate blog post archives}
  spec.homepage      = "https://coffeebrewapps.com/coffeebrew_jekyll_archives"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files            = Dir["lib/**/*.rb", "lib/**/*.yml"]
  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE"]
  spec.test_files       = spec.files.grep(%r!^spec/!)
  spec.require_paths    = ["lib/coffeebrew_jekyll_archives", "lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "jekyll", ">= 4.0", "< 5.0"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "rspec", "~> 3.12.0"
  spec.add_development_dependency "rubocop-jekyll", "~> 0.13.0"
  spec.add_development_dependency "rubocop-rake", "~> 0.6.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.19.0"
end
