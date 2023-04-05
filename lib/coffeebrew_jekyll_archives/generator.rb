# frozen_string_literal: true

require_relative "./page"
require_relative "./validator"

module Coffeebrew
  module Jekyll
    module Archives
      class Generator < ::Jekyll::Generator
        safe true
        priority :lowest

        def generate(site)
          @site = site

          validate!

          @site.pages << root_page
          @site.data["archives"] = root_page

          return unless navigation_config

          generate_navigation
        end

        private

        def config
          @config ||= ::Jekyll::Utils.deep_merge_hashes(default_config["archives"], @site.config["archives"].to_h)
        end

        def validate!
          validator = Coffeebrew::Jekyll::Archives::Validator.new(config)
          validator.validate!
        end

        def root_page
          @root_page ||= Coffeebrew::Jekyll::Archives::Page.new(
            :root, @site, config, nil, @site.posts.docs, config["depths"],
            year: 1, month: 1, day: 1
          )
        end

        def navigation_config
          @navigation_config ||= config["navigation"]
        end

        def navigation_data
          @navigation_data ||= @site.data[navigation_config["data"]]
        end

        def default_config_path
          @default_config_path ||= File.expand_path("config.yml", __dir__)
        end

        def default_config
          @default_config ||= YAML.safe_load(File.read(default_config_path))
        end

        def menu_data
          @menu_data ||= {
            "name" => navigation_config["name"],
            "link" => root_page.url
          }
        end

        def find_menu_index(menu_name)
          navigation_data.index do |menu|
            menu["name"] == menu_name
          end
        end

        def insert_position
          @insert_position ||= if navigation_config["before"]
                                 [navigation_config["before"], 0]
                               elsif navigation_config["after"]
                                 [navigation_config["after"], 1]
                               else
                                 []
                               end
        end

        def generate_navigation
          if insert_position.empty?
            navigation_data << menu_data
          else
            menu_name, offset = insert_position
            found_index = find_menu_index(menu_name)
            navigation_data.insert(found_index + offset, menu_data)
          end
        end
      end
    end
  end
end
