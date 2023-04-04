# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

TEMPLATE_DIR = File.expand_path("templates", __dir__)
SCENARIO_DIR = File.expand_path("spec/scenarios", __dir__)

namespace :coffeebrew do
  namespace :jekyll do
    namespace :archives do
      namespace :test do
        task :create_success, [:scenario_name] do |t, args|
          scenario_name = args[:scenario_name]
          scenario_name_upcase = scenario_name.upcase
          template = File.join(TEMPLATE_DIR, "success_context.rb")
          template_content = File.read(template)
          content = template_content % { scenario_name: scenario_name, scenario_name_upcase: scenario_name_upcase }
          scenario_dir = File.join(SCENARIO_DIR, scenario_name)
          scenario_file = File.join(scenario_dir, "context.rb")
          site_dir = File.join(scenario_dir, "_site")

          if File.exist?(scenario_dir)
            exit 0
          end

          FileUtils.mkdir(scenario_dir)
          FileUtils.mkdir(site_dir)
          File.write(scenario_file, content)

          puts "Created new success scenario in #{scenario_dir}: "
          system("ls -lG #{scenario_dir}")
        end

        task :create_failure, [:scenario_name] do |t, args|
          scenario_name = args[:scenario_name]
          scenario_name_upcase = scenario_name.upcase
          template = File.join(TEMPLATE_DIR, "failure_context.rb")
          template_content = File.read(template)
          content = template_content % { scenario_name: scenario_name, scenario_name_upcase: scenario_name_upcase }
          scenario_dir = File.join(SCENARIO_DIR, scenario_name)
          scenario_file = File.join(scenario_dir, "context.rb")

          if File.exist?(scenario_dir)
            exit 0
          end

          FileUtils.mkdir(scenario_dir)
          File.write(scenario_file, content)

          puts "Created new failure scenario in #{scenario_dir}: "
          system("ls -lG #{scenario_dir}")
        end
      end
    end
  end
end
