# Jekyll Archives Plugin

A Jekyll plugin to generate site post archives.

[![Continuous Integration](https://github.com/coffeebrewapps/coffeebrew_jekyll_archives/actions/workflows/ruby.yml/badge.svg)](https://github.com/coffeebrewapps/coffeebrew_jekyll_archives/actions/workflows/ruby.yml) [![Gem Version](https://badge.fury.io/rb/coffeebrew_jekyll_archives.svg)](https://badge.fury.io/rb/coffeebrew_jekyll_archives)

## Installation

Add this line to your site's Gemfile:

```ruby
gem 'coffeebrew_jekyll_archives'
```

And then add this line to your site's `_config.yml`:

```yml
plugins:
  - coffeebrew_jekyll_archives
```

Upon building the Jekyll site, the plugin will automatically generate the archive indexes using the following default
configuration:

```yml
---
archives:
  navigation:
    data: "navigation"
    name: "Archives"
    before:
    after:
  depths: 3
  title_format:
    root:
      type: "string"
      style: "/"
    year:
      type: "date"
      style: "%Y"
    month:
      type: "date"
      style: "%b, %Y"
    day:
      type: "date"
      style: "%d %b, %Y"
  root_dir: "/"
  root_basename: "archives"
  index_root: "/archives"
  index_basename: "index"
  permalink:
    root: "/:root_dir"
    year: "/:root_dir/:index_root/:year"
    month: "/:root_dir/:index_root/:year/:month"
    day: "/:root_dir/:index_root/:year/:month/:day"
```

An example of the generated directory structure is as such:

```bash
_site/
├── archives
│   └── 2023
│       ├── 03
│       │   ├── 30
│       │   │   └── index.html
│       │   └── index.html
│       └── index.html
├── archives.html
└── index.html
```

## Configuration

You can override any of the default configuration values above. The plugin will perform a simple validation on your
overrides according to these rules:

### Navigation config

This tells the plugin how to generate navigation menu.

| Key | Allowed Value(s) | Default | Remark |
| --- | --- | --- | --- |
| data | String | navigation | This tells the plugin where in `site.data[]` to get the navigation data. Usually this would be set in `site.data["navigation"]`. |
| name | String | Archives | This is the name rendered in the navigation menu item. |
| before | String | nil | This tells the plugin before which existing menu item to insert the archives' root index menu item. |
| after | String | nil | This tells the plugin after which existing menu item to insert the archives' root index menu item. |

When `before` and `after` are `nil`, the archives' root index menu item will be appended last.

If both `before` and `after` are configured, `before` config will be used and `after` will be ignored.

### Depths config

This tells the plugin what indexes to generate.

There are 3 levels of depths:

| Level | Description |
| --- | --- |
| 1 | Generate yearly index only |
| 2 | Generate yearly and monthly indexes |
| 3 | Generate yearly, monthly and daily indexes |

### Title format config

This tells the plugin what is the format of the title to be used for the index entries.

There are 4 titles that can be generated:

| Level | Description |
| --- | --- |
| root | This will be used for the root index entry |
| year | This will be used for the yearly index entries |
| month | This will be used for the monthly index entries |
| day | This will be used for the daily index entries |

For each title format, you can use one of these types:

| Type | Description |
| --- | --- |
| string | A string that uses format syntax and use available variables: year, month, day, eg. `Archive of %{year}-%{month}-%{day}` will be interpreted as `Archive of 2023-03-12` |
| date | A string that strictly uses Ruby date identifiers, the plugin will call `date.strftime()` on the format string, eg. `%d %b, %Y` will be interpreted as `12 Mar, 2023` |

### Directory and path config

This tells the plugin how to create the directory structure and index page file name.

| Key | Allowed Value(s) | Default | Remark |
| --- | --- | --- | --- |
| root_dir | String | / | This tells the plugin what is the root directory to create the root index page. |
| root_basename | String | archives | This tells the plugin what is the root index page file name, with `.html` as the extension. |
| index_root | String | /archives | This tells the plugin what is the root directory for the yearly/monthly/daily index pages to be generated. |
| index_basename | String | index | This tells the plugin what is the file name to use for the yearly/monthly/daily index pages, with `.html` as the extension. |

### Permalink config

This tells the plugin how to create the directory structure of the yearly/monthly/daily index pages, and the permalink
for the index pages will follow the directory structure.

There are 4 levels of pages that can be generated:

| Level | Description |
| --- | --- |
| root | This will be used for the root index entry |
| year | This will be used for the yearly index entries |
| month | This will be used for the monthly index entries |
| day | This will be used for the daily index entries |

A few placeholders are available to be used in the permalink:

| Field | Description |
| --- | --- |
| root_dir | This will be the root directory where the root index page is created. |
| index_root | This will be the root directory where the yearly/monthly/daily index pages are created. |
| year | This will be the current year of the current index page. If the current page is the root index, then `year` will always be `0001`. |
| month | This will be the current month of the current index page. If the current page is a yearly index, then `month` will always be `01`. |
| day | This will be the current day of the current index page. If the current page is a yearly or monthly index, then `day` will always be `01`. |

### Validation

If the config overrides have invalid structure, keys or values, the plugin will raise a
`Jekyll::Errors::InvalidConfigurationError` during build.

## Layout

The plugin does not provide a default layout. You will need to create your own layout in `_layouts` and configure the
defaults in `_config.yml`:

```yml
---
defaults:
  - scope:
      type: "archives"
    values:
      layout: "archive"
      permalink: /:path/:basename:output_ext
```

In addition to Jekyll's default page data, you can also use the page data generated by the plugin in the layout:

| Field | Description |
| --- | --- |
| dir | The current index page directory.  |
| sub_pages | The current index page's sub-pages according to the hierarchy of: 1) root, 2) yearly, 3) monthly, 4) daily. If the current page is the daily index page, then there will be no sub-pages. |
| root | The root index page absolute url. This is useful if you need to highlight the archives' root navigation menu item while displaying the nested index pages. |
| ancestors | The ancestors of the current page. This is useful if you need to render a tree view of the ancestor pages relative to the current page. |
| parent | The immediate parent of the current page. |
| collection | The posts collection under the current index page, eg. if the current page is a monthly index page, then all the current month's posts will be available. |
| title | The title generated for the current page according to the `title_format` config. |
| year | The current year of the current index page. If the current page is the root index, then `year` will always be `0001`. |
| month | The current month of the current index page. If the current page is a yearly index, then `month` will always be `01`. |
| day | The current day of the current index page. If the current page is a yearly or monthly index, then `day` will always be `01`. |

An example of a layout that is used by the plugin's test cases:

```html
---
layout: default
---
<h1>Archives of {{ page.title }}</h1>
<div class="archives">
  {% for ancestor in page.ancestors %}
    <ul>
      <li>
        <i class="fa-solid fa-calendar-days"></i>
        <a href="{{ ancestor.url }}">{{ ancestor.title }}</a>
      </li>
  {% endfor %}
      <ul>
        <li>
          <i class="fa-solid fa-calendar-days"></i>
          <a href="{{ page.url }}">{{ page.title }}</a>
        </li>
        {% if page.sub_pages.size > 0 %}
          <ul>
            {% for sub_page in page.sub_pages %}
              <li>
                <i class="fa-solid fa-calendar-days"></i>
                <a href="{{ sub_page.url }}">{{ sub_page.title }}</a>
              </li>
            {% endfor %}
          </ul>
        {% else %}
          <ul>
            {% for item in page.collection %}
              <li>
                <i class="fa-solid fa-file"></i>
                <a href="{{ item.url }}">{{ item.date | date: "%d %b, %Y" }} - {{ item.title }}</a>
              </li>
            {% endfor %}
          </ul>
        {% endif %}
      </ul>
  {% for ancestor in page.ancestors %}
    </ul>
  {% endfor %}
</div>
```

The resulting index pages are as such:

### Root

Generated at: `_site/archives.html`.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>/</title>
  </head>
  <body>
    <nav>
      <a href="/">Home</a>
      <a href="/about.html">About</a>
      <a href="/articles.html">Articles</a>
      <a href="/projects.html">Projects</a>
      <a href="/archives.html">Archives</a>
    </nav>

    <div class="container">
      <h1>Archives of /</h1>
      <div class="archives">
        <ul>
          <li>
            <i class="fa-solid fa-calendar-days"></i>
            <a href="/archives.html">/</a>
          </li>
          <ul>
            <li>
              <i class="fa-solid fa-calendar-days"></i>
              <a href="/archives/2021/index.html">2021</a>
            </li>
            <li>
              <i class="fa-solid fa-calendar-days"></i>
              <a href="/archives/2022/index.html">2022</a>
            </li>
            <li>
              <i class="fa-solid fa-calendar-days"></i>
              <a href="/archives/2023/index.html">2023</a>
            </li>
          </ul>
        </ul>
      </div>
    </div>
  </body>
</html>
```

### Yearly index

Generated at: `_site/2021/index.html` for the year of 2021.

Note: Header and navigation elements omitted for clarity.

```html
<div class="container">
  <h1>Archives of 2021</h1>
  <div class="archives">
    <ul>
      <li>
        <i class="fa-solid fa-calendar-days"></i>
        <a href="/archives.html">/</a>
      </li>
      <ul>
        <li>
          <i class="fa-solid fa-calendar-days"></i>
          <a href="/archives/2021/index.html">2021</a>
        </li>
        <ul>
          <li>
            <i class="fa-solid fa-calendar-days"></i>
            <a href="/archives/2021/03/index.html">Mar, 2021</a>
          </li>
          <li>
            <i class="fa-solid fa-calendar-days"></i>
            <a href="/archives/2021/05/index.html">May, 2021</a>
          </li>
        </ul>
      </ul>
    </ul>
  </div>
</div>
```

### Monthly index

Generated at: `_site/2021/03/index.html` for the month of March 2021.

Note: Header and navigation elements omitted for clarity.

```html
<div class="container">
  <h1>Archives of Mar, 2021</h1>
  <div class="archives">
    <ul>
      <li>
        <i class="fa-solid fa-calendar-days"></i>
        <a href="/archives.html">/</a>
      </li>
      <ul>
        <li>
          <i class="fa-solid fa-calendar-days"></i>
          <a href="/archives/2021/index.html">2021</a>
        </li>
        <ul>
          <li>
            <i class="fa-solid fa-calendar-days"></i>
            <a href="/archives/2021/03/index.html">Mar, 2021</a>
          </li>
          <ul>
            <li>
              <i class="fa-solid fa-calendar-days"></i>
              <a href="/archives/2021/03/12/index.html">12 Mar, 2021</a>
            </li>
            <li>
              <i class="fa-solid fa-calendar-days"></i>
              <a href="/archives/2021/03/28/index.html">28 Mar, 2021</a>
            </li>
          </ul>
        </ul>
      </ul>
    </ul>
  </div>
</div>
```

### Daily index

Generated at: `_site/2021/03/12/index.html` for the day of 12 March 2021.

Note: Header and navigation elements omitted for clarity.

```html
<div class="container">
  <h1>Archives of 12 Mar, 2021</h1>
  <div class="archives">
    <ul>
      <li>
        <i class="fa-solid fa-calendar-days"></i>
        <a href="/archives.html">/</a>
      </li>
      <ul>
        <li>
          <i class="fa-solid fa-calendar-days"></i>
          <a href="/archives/2021/index.html">2021</a>
        </li>
        <ul>
          <li>
            <i class="fa-solid fa-calendar-days"></i>
            <a href="/archives/2021/03/index.html">Mar, 2021</a>
          </li>
          <ul>
            <li>
              <i class="fa-solid fa-calendar-days"></i>
              <a href="/archives/2021/03/12/index.html">12 Mar, 2021</a>
            </li>
            <ul>
              <li>
                <i class="fa-solid fa-file"></i>
                <a href="/2021/03/12/test-post-1.html">12 Mar, 2021 - This is test post 1</a>
              </li>
            </ul>
          </ul>
        </ul>
      </ul>
    </ul>
  </div>
</div>
```

## Contributing

Contribution to the gem is very much welcome!

1. Fork it (https://github.com/coffeebrewapps/coffeebrew_jekyll_archives/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Make sure you have setup the repo correctly so that you can run RSpec and Rubocop on your changes. Read more under the [Development](#development) section.
4. Commit your changes (`git commit -am 'Add some feature'`).
5. If you have added something that is worth mentioning in the README, please also update the README.md accordingly and commit the changes.
6. Push to the branch (`git push origin my-new-feature`).
7. Create a new Pull Request.

The repo owner will try to respond to a new PR as soon as possible.

## Development

We want to provide a robust gem as much as possible for the users, so writing test cases will be required for any new
feature.

If you are contributing to the gem, please make sure you have setup your development environment correctly so that
RSpec and Rubocop can run properly.

1. After forking the repo, go into the repo directory (`cd coffeebrew_jekyll_archives/`).
2. Make sure you have the correct Ruby version installed. This gem requires Ruby >= 2.7.0.
3. Once you have the correct Ruby version, install the development dependencies (`bundle install`).
4. To test that you have everything installed correctly, run the test cases (`bundle exec rspec`).
5. You should see all test cases pass successfully.

### Source directory structure

All the gem logic lives in the `/lib` directory:

```bash
lib
├── coffeebrew_jekyll_archives
│   ├── config.yml
│   ├── generator.rb
│   ├── page.rb
│   ├── validator.rb
│   └── version.rb
└── coffeebrew_jekyll_archives.rb
```

The files that are currently in the repo:

| File | Description |
| --- | --- |
| `lib/coffeebrew_jekyll_archives/config.yml` | This contains the default configuration for the plugin to generate the archive indexes. |
| `lib/coffeebrew_jekyll_archives/generator.rb` | This is the generator that reads the configuration and generate the index pages. |
| `lib/coffeebrew_jekyll_archives/page.rb` | This is the abstract model of the index pages. |
| `lib/coffeebrew_jekyll_archives/validator.rb` | This validates the configuration. |
| `lib/coffeebrew_jekyll_archives/version.rb` | This contains the version number of the gem. |
| `lib/coffeebrew_jekyll_archives.rb` | This is the entry point of the gem, and it loads the dependencies. |

### Test cases directory structure

All the test cases and fixtures live in the `/spec` directory:

Note: Some files have been omitted for clarity.

```bash
spec
├── coffeebrew_jekyll_archives_spec.rb
├── dest
├── fixtures
│   ├── _config.yml
│   ├── _data
│   │   └── navigation.yml
│   ├── _includes
│   │   └── navigation.html
│   ├── _layouts
│   │   ├── archive.html
│   │   └── default.html
│   └── _posts
│       ├── 2021-03-12-test-post-1.md
│       ├── 2021-03-28-test-post-2.md
│       ├── 2021-05-03-test-post-3.md
│       ├── 2021-05-03-test-post-4.md
│       ├── 2022-01-27-test-post-5.md
│       ├── 2022-03-12-test-post-6.md
│       ├── 2022-11-23-test-post-7.md
│       └── 2023-02-21-test-post-8.md
├── scenarios
│   ├── default
│   │   ├── _site
│   │   │   ├── archives
│   │   │   │   ├── 2021
│   │   │   │   │   ├── 03
│   │   │   │   │   │   ├── 12
│   │   │   │   │   │   │   └── index.html
│   │   │   │   │   │   ├── 28
│   │   │   │   │   │   │   └── index.html
│   │   │   │   │   │   └── index.html
│   │   │   │   │   ├── 05
│   │   │   │   │   │   ├── 03
│   │   │   │   │   │   │   └── index.html
│   │   │   │   │   │   └── index.html
│   │   │   │   │   └── index.html
│   │   │   │   └── 2023
│   │   │   │       ├── 02
│   │   │   │       │   ├── 21
│   │   │   │       │   │   └── index.html
│   │   │   │       │   └── index.html
│   │   │   │       └── index.html
│   │   │   └── archives.html
│   │   └── context.rb
│   └── invalid_config_keys
│       └── context.rb
└── spec_helper.rb
```

The files that are currently in the repo:

| File | Description |
| --- | --- |
| `spec/coffeebrew_jekyll_archives_spec.rb` | This is the main RSpec file to be executed. It contains all the contexts of various scenarios. |
| `spec/dest/` | This directory is where generated files are located. It will be deleted immediately after each context is executed. |
| `spec/fixtures/` | This directory follows the Jekyll site source structure and contains the minimal files required to generate the archive index pages. |
| `spec/fixtures/_posts` | This directory contains the test posts, you can add more to it to test your new feature. |
| `spec/scenarios/` | This directory contains the expected files of various test scenarios. |
| `spec/scenarios/<scenario>/` | This is the scenario name. |
| `spec/scenarios/<scenario>/_site/` | This directory contains the expected archive index pages. |
| `spec/scenarios/<scenario>/context.rb` | This is the file that sets up the context for the test case. |
| `spec/spec_helper.rb` | This contains RSpec configuration and certain convenience methods for the main RSpec file. |

### Writing test cases

There is a certain convention to follow when writing new test scenarios. The recommendation is to use the rake tasks
provided in the gem to generate the scenario files.

For success scenarios, run:

```bash
bundle exec rake coffeebrew:jekyll:archives:test:create_success[test_scenario]
```

This will generate a placeholder file and directory:

```bash
spec
├── coffeebrew_jekyll_archives_spec.rb
├── scenarios
│   └── test_scenario
│       ├── _site
│       └── context.rb
└── spec_helper.rb
```

Where the `context.rb` file will be pre-populated:

```ruby
# frozen_string_literal: true

CONTEXT_TEST_SCENARIO = "when using test_scenario config"

RSpec.shared_context CONTEXT_TEST_SCENARIO do
  let(:scenario) { "test_scenario" }
  let(:overrides) {} # TODO: remove if unused
  let(:generated_files) {} # TODO: remove if unused
  let(:expected_files) do
    [
    ]
  end
end
```

For failure scenarios, run:

```bash
bundle exec rake coffeebrew:jekyll:archives:test:create_failure[test_scenario]
```

This will generate a placeholder file and directory:

```bash
spec
├── coffeebrew_jekyll_archives_spec.rb
├── scenarios
│   └── test_scenario
│       └── context.rb
└── spec_helper.rb
```

Where the `context.rb` file will be pre-populated:

```ruby
# frozen_string_literal: true

CONTEXT_TEST_SCENARIO = "when using test_scenario config"

RSpec.shared_context CONTEXT_TEST_SCENARIO do
  let(:scenario) { "test_scenario" }
  let(:generated_files) { [] }
  let(:expected_files) { [] }
  let(:overrides) do
    {
    }
  end

  let(:expected_errors) do
    [
    ]
  end
end
```

If you do write other test cases that are not asserting the generated files like above, you can initiate your
convention. The repo owner will evaluate the PR and accept the convention if it fits the repo existing convention, or
will recommend an alternative if it doesn't.

## License

See the [LICENSE](/LICENSE) file.
