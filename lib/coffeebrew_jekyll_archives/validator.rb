# frozen_string_literal: true

module Coffeebrew
  module Jekyll
    module Archives
      class Validator
        ALLOWED_CONFIG_KEYS = {
          "navigation" => {
            "data" => [],
            "name" => [],
            "before" => [],
            "after" => []
          },
          "depths" => [1, 2, 3],
          "title_format" => {
            "root" => {
              "type" => %w[string date],
              "style" => []
            },
            "year" => {
              "type" => %w[string date],
              "style" => []
            },
            "month" => {
              "type" => %w[string date],
              "style" => []
            },
            "day" => {
              "type" => %w[string date],
              "style" => []
            }
          },
          "root_dir" => [],
          "root_basename" => [],
          "index_root" => [],
          "index_basename" => [],
          "permalink" => {
            "root" => [],
            "year" => [],
            "month" => [],
            "day" => []
          }
        }.freeze

        def initialize(config)
          @config = config
          @errors = []
        end

        def validate!
          parse(@config, ALLOWED_CONFIG_KEYS, ["archives"])

          return if @errors.empty?

          ::Jekyll.logger.error "'archives' config is set incorrectly."
          ::Jekyll.logger.error "Errors:", @errors

          raise ::Jekyll::Errors::InvalidConfigurationError, "'archives' config is set incorrectly."
        end

        private

        def parse(hash, allowed_keys, parent_key)
          hash.each do |key, configured_value|
            allowed_values = allowed_keys[key]
            new_parent_key = parent_key + [key]

            next if configured_in_allowed_values?(allowed_values, configured_value)

            if same_hash_type?(allowed_values, configured_value)
              next parse(configured_value, allowed_values, new_parent_key)
            end

            add_error(new_parent_key, allowed_values, configured_value)
          end
        end

        def same_hash_type?(allowed_values, configured_value)
          allowed_values.is_a?(Hash) && configured_value.is_a?(Hash)
        end

        def primitive?(value)
          value.nil? || value.is_a?(String) || value.is_a?(Numeric)
        end

        def configured_in_allowed_values?(allowed_values, configured_value)
          allowed_values.is_a?(Array) && primitive?(configured_value) &&
            (allowed_values.empty? || allowed_values.include?(configured_value))
        end

        def add_error(parent_key, allowed_values, configured_value)
          @errors << { key: parent_key.join("."), expected: allowed_values, got: configured_value }
        end
      end
    end
  end
end
