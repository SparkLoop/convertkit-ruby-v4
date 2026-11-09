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

# VCR records a real response inside a cassette and replays it later. Outside a cassette,
# the config above lets requests reach Kit's live API, which most specs rely on.
#
# Kit accepts credentials both in the URL and in the headers/body, so a live or recorded
# call would pass either way. Specs tagged :offline check the request we build, not Kit's
# response: VCR is off and real connections are blocked while they run, so a request that
# doesn't match the stub fails instead of reaching Kit. Real connections are allowed again
# afterwards for the live specs.
RSpec.shared_context "offline" do
  around do |example|
    VCR.turned_off do
      WebMock.disable_net_connect!
      example.run
    ensure
      WebMock.allow_net_connect!
    end
  end
end

RSpec.configure do |config|
  config.include_context "offline", :offline
end
