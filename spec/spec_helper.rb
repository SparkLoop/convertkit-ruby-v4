$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'convertkit_v4'
require "dotenv"
Dotenv.load(".env.local")

require 'webmock/rspec'
require 'vcr'

ConvertkitV4.configure do |config|
  config.access_token = ENV["CONVERTKIT_ACCESS_TOKEN"]
end

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<ACCESS_TOKEN>") { ENV["CONVERTKIT_ACCESS_TOKEN"] }
  config.allow_http_connections_when_no_cassette = true
end

WebMock.allow_net_connect!
