require "spec_helper"
require "securerandom"

module ConvertkitV4
  class Client
    describe Broadcasts do
      before do
        ConvertkitV4.configure do |config|
          config.api_secret = ENV["API_SECRET"]
          config.api_key = ENV["API_KEY"]
        end

        @client = ConvertkitV4::Client.new
      end

      describe "#broadcasts" do
        it "sends the right request" do
          r = @client.broadcasts
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Authorization Failed", "message"=>"API Key not present"})
        end
      end

      describe "#broadcast" do
        it "sends the right request" do
          broadcast_id = ENV['BROADCAST_ID']

          r = @client.broadcast(broadcast_id)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Not Found", "message"=>"The entity you were trying to find doesn't exist"})
        end
      end

      describe "#broadcast_stats" do
        it "sends the right request" do
          broadcast_id = ENV['BROADCAST_ID']

          r = @client.broadcast_stats(broadcast_id)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Not Found", "message"=>"The entity you were trying to find doesn't exist"})
        end
      end
    end
