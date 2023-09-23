require "spec_helper"
require "base64"

module ConvertkitV4
  describe Client do
    before :each do
      @client = ConvertkitV4::Client.new
    end

    describe "#initialize" do
      it "has a default client_id value" do
        expect(@client.client_id).to eq(ENV["CONVERTKIT_CLIENT_ID"])
      end

      it "has a default client_secret value" do
        expect(@client.client_secret).to eq(ENV["CONVERTKIT_CLIENT_SECRET"])
      end

      it "has a default redirect_uri value" do
        expect(@client.redirect_uri).to eq(ENV["CONVERTKIT_REDIRECT_URI"])
      end
    end
  end
end
