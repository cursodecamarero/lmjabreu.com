# If you have OpenSSL installed, we recommend updating the following line to
# use "https".
source 'http://rubygems.org'

def is_mac?
  RUBY_PLATFORM.downcase.include?("darwin")
end

gem 'middleman', '~> 3.2.2'
gem 'middleman-blog', '~> 3.5.2'
gem 'middleman-favicon-maker', '~> 3.5'
gem 'middleman-livereload', '~> 3.2.1'
gem 'middleman-alias'
gem "rb-inotify" unless is_mac?
gem "therubyracer"

# For feed.xml.builder
gem 'builder', '~> 3.2.2'

# Code syntax highlighting
gem 'middleman-syntax', '~> 2.0.0'
gem 'redcarpet', '~> 3.1.1'

# For "summary"-Helper
gem 'nokogiri', '~> 1.6.1'
gem 'sanitize', '~> 2.1.0'
