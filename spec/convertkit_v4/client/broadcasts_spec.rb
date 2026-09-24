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
        let(:broadcasts) { [{ "id" => 1, "subject" => "Hi", "send_at" => "2026-01-01T00:00:00Z" }] }
        let(:query) { {} }

        before do
          stub_request(:get, "https://api.convertkit.com/v4/broadcasts")
            .with(query: query)
            .to_return(
              status: 200,
              headers: { "Content-Type" => "application/json" },
              body: { "broadcasts" => broadcasts }.to_json
            )
        end

        it "lists broadcasts with no query params" do
          expect(@client.broadcasts).to eq(broadcasts)
        end

        context "with per_page and slim" do
          let(:query) { { "per_page" => "3", "slim" => "true" } }

          it "passes them as query params" do
            expect(@client.broadcasts(per_page: 3, slim: true)).to eq(broadcasts)
            expect(WebMock).to have_requested(:get, "https://api.convertkit.com/v4/broadcasts")
              .with(query: query)
          end
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
  end
end
