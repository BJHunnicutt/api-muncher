require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

require 'vcr'
require 'webmock/minitest'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  Minitest::Reporters.use!

  VCR.configure do |config|
    # ******If something changes to your program delete the contents of test/cassettes - its the data "recording" from the API
    config.cassette_library_dir = 'test/cassettes' # folder where casettes will be located
    config.hook_into :webmock # tie into this other tool called webmock
    config.default_cassette_options = {
      :record => :new_episodes,    # record new data when we don't have it yet
      :match_requests_on => [:method, :uri, :body] # The http method, URI and body of a request all need to match
    }
  end
end