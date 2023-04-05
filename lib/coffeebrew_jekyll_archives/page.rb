# frozen_string_literal: true

module Coffeebrew
  module Jekyll
    module Archives
      class Page < ::Jekyll::Page # rubocop:disable Metrics/ClassLength
        HIERARCHY = {
          "root" => "year",
          "year" => "month",
          "month" => "day"
        }.freeze

        DEPTHS = {
          "root" => 0,
          "year" => 1,
          "month" => 2,
          "day" => 3
        }.freeze

        attr_reader :type, :date, :parent, :collection

        def initialize(type, site, config, parent, collection, depths, year:, month:, day:) # rubocop:disable Lint/MissingSuper, Metrics/ParameterLists
          @type = type
          @site = site
          @config = config
          @base = site.source
          @date = Date.new(year.to_i, month.to_i, day.to_i)
          @ext = ".html"
          @parent = parent
          @collection = collection
          @depths = depths
          build_data
        end

        def sub_pages
          @sub_pages ||= if current_depth < @depths
                           child_type = HIERARCHY[type.to_s].to_sym
                           group_collection_by(collection, child_type).each_with_object([]) do |(attr, items), pages|
                             fields = date_fields.merge(child_type => attr)
                             child_page = Page.new(child_type, @site, @config, self, items, @depths, **fields)
                             add_child_page(pages, child_page)
                           end
                         else
                           []
                         end
        end

        def url_placeholders
          {
            path: dir,
            basename: basename,
            output_ext: output_ext
          }
        end

        def ancestors
          @ancestors ||= begin
            arr = []
            current_parent = parent
            while current_parent
              arr.unshift(current_parent)
              current_parent = current_parent.parent
            end
            arr
          end
        end

        def dir
          @dir ||= begin
            format = @config.dig("permalink", type.to_s)
            ::Jekyll::URL.new(
              template: format,
              placeholders: dir_placeholders,
              permalink: nil
            ).to_s
          end
        end

        def year
          @year ||= date.strftime("%Y")
        end

        def month
          @month ||= date.strftime("%m")
        end

        def day
          @day ||= date.strftime("%d")
        end

        def title
          @title ||= case title_format_type
                     when :date
                       date.strftime(title_format_style)
                     when :string
                       format(title_format_style, year: year, month: month, day: day)
                     end
        end

        def basename
          @basename ||= case type.to_sym
                        when :root
                          @config["root_basename"]
                        else
                          @config["index_basename"]
                        end
        end

        def name
          @name ||= "#{basename}#{ext}"
        end

        private

        def date_fields
          @date_fields ||= { year: year, month: month, day: day }
        end

        def add_child_page(pages, child_page)
          pages << child_page
          @site.pages << child_page
        end

        def dir_placeholders
          @dir_placeholders ||= {
            root_dir: @config["root_dir"],
            index_root: @config["index_root"],
            year: year,
            month: month,
            day: day
          }
        end

        def current_depth
          @current_depth ||= DEPTHS[type.to_s]
        end

        def title_format
          @title_format ||= @config.dig("title_format", type.to_s)
        end

        def title_format_type
          @title_format_type ||= title_format["type"].to_sym
        end

        def title_format_style
          @title_format_style ||= title_format["style"]
        end

        def root_index_path
          @root_index_path ||= "#{@config['root_dir']}#{@config['root_basename']}.html"
        end

        def build_data # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          @data = {
            "dir" => dir,
            "sub_pages" => sub_pages,
            "root" => root_index_path,
            "ancestors" => ancestors,
            "parent" => parent,
            "collection" => collection,
            "title" => title,
            "year" => year,
            "month" => month,
            "day" => day
          }

          data.default_proc = proc do |_, key|
            site.frontmatter_defaults.find(relative_path, :archives, key)
          end
        end

        def group_collection_by(collection, attr)
          collection.group_by do |item|
            item.date.send(attr)
          end
        end
      end
    end
  end
end
