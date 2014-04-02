require 'sanitize'

###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  blog.prefix = "post"
  blog.permalink = "/:title"
  # blog.sources = ":year-:month-:day-:title.html"
  # blog.taglink = "tags/:tag.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  # blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  blog.paginate = true
  # set in index.haml
  # blog.per_page = 1
  # blog.page_link = "/:num"
end

# Required
set :blog_url, 'http://lmjabreu.com'
set :blog_name, 'UX & UI Designer.'
set :blog_description, 'the thoughts of'
set :author_name, 'Luis Abreu'
set :author_bio, 'Independent Digital Experience Designer and iOS, Web Developer. ' \
                 'Into Cognitive Science, Systems Thinking, Future, Science.'
set :author_email, 'hello@lmjabreu.com'
set :author_twitter, 'lmjabreu'
# Optional
set :author_location, ''
set :author_website, ''
set :blog_logo, ''

page '/feed.xml', layout: false

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
compass_config do |config|
  config.output_style = :compact
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def page_title
    title = author_name.dup
    if current_page.data.title
      title << ": #{current_page.data.title}"
    elsif is_blog_article?
      title << ": #{current_article.title}"
    end
    title
  end

  def nav_link_to(link, url, opts={})
    opts[:class] ||= ""
    opts[:class] << " active" if url == current_page.url.gsub(/\b(\/)$/, '')
    link_to(link, url, opts)
  end

  def page_description
    if is_blog_article?
      Sanitize.clean(current_article.summary(150, '')).strip.gsub(/\s+/, ' ')
    else
      blog_description
    end
  end

  def page_class
    page_class = 'default-template'
    page_class = 'post-template' if is_blog_article?
    page_class = 'page-template' if is_page?

    page_class
  end

  def summary(article)
    Sanitize.clean(article.summary, whitespace_elements: %w(h1))
  end

  def author
    {
      bio: author_bio,
      location: author_location,
      name: author_name,
      website: author_website
    }
  end

  def tags?(article = current_article)
    article.tags.present?
  end

  def tags(article = current_article, separator = ' | ')
    article.tags.join(separator)
  end

  def current_article_url
    URI.join(blog_url, current_article.url)
  end

  def blog_logo?
    return false if blog_logo.blank?
    File.exists?(File.join('source', images_dir, blog_logo))
  end

  def twitter_url
    "https://twitter.com/share?text=#{current_article.title}" \
      "&amp;url=#{current_article_url}"
  end

  def facebook_url
    "https://www.facebook.com/sharer/sharer.php?u=#{current_article_url}"
  end

  def google_plus_url
    "https://plus.google.com/share?url=#{current_article_url}"
  end

  def feed_path
    '/feed.xml'
  end
end

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: true

# Pretty URLs - http://middlemanapp.com/pretty-urls/
activate :directory_indexes

# LiveReload - http://middlemanapp.com/livereload/
# activate :livereload

activate :pages_directory

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Generate touch and fav icons
  activate :favicon_maker, :icons => {
    'images/favicon.png' => [
      { icon: 'images/apple-touch-icon-144x144-precomposed.png' },
      { icon: 'images/apple-touch-icon-114x114-precomposed.png' },
      { icon: 'images/apple-touch-icon-72x72-precomposed.png' }
    ]
  }

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
