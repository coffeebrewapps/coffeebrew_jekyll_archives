# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "logger"

logger = Logger.new($stdout)
logger.level = Logger::DEBUG

RSpec::Core::RakeTask.new(:spec)

task default: :spec

TEMPLATE_DIR = File.expand_path("templates", __dir__)
SCENARIO_DIR = File.expand_path("spec/scenarios", __dir__)

namespace :coffeebrew do
  namespace :jekyll do
    namespace :archives do
      namespace :test do
        desc "Create a success scenario test files"
        task :create_success, [:scenario_name] do |_t, args|
          scenario_name = args[:scenario_name]
          scenario_name_upcase = scenario_name.upcase
          template = File.join(TEMPLATE_DIR, "success_context.rb")
          template_content = File.read(template)
          content = format(template_content, scenario_name: scenario_name, scenario_name_upcase: scenario_name_upcase)
          scenario_dir = File.join(SCENARIO_DIR, scenario_name)
          scenario_file = File.join(scenario_dir, "context.rb")
          site_dir = File.join(scenario_dir, "_site")

          exit 0 if File.exist?(scenario_dir)

          FileUtils.mkdir(scenario_dir)
          FileUtils.mkdir(site_dir)
          File.write(scenario_file, content)

          logger.debug "Created new success scenario in #{scenario_dir}: "
          system("ls -lG #{scenario_dir}")
        end

        desc "Create a failure scenario test files"
        task :create_failure, [:scenario_name] do |_t, args|
          scenario_name = args[:scenario_name]
          scenario_name_upcase = scenario_name.upcase
          template = File.join(TEMPLATE_DIR, "failure_context.rb")
          template_content = File.read(template)
          content = format(template_content, scenario_name: scenario_name, scenario_name_upcase: scenario_name_upcase)
          scenario_dir = File.join(SCENARIO_DIR, scenario_name)
          scenario_file = File.join(scenario_dir, "context.rb")

          exit 0 if File.exist?(scenario_dir)

          FileUtils.mkdir(scenario_dir)
          File.write(scenario_file, content)

          logger.debug "Created new failure scenario in #{scenario_dir}: "
          system("ls -lG #{scenario_dir}")
        end
      end
    end
  end
end
