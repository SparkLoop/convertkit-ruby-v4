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

    describe "OAuth token requests" do
      around do |example|
        VCR.turned_off do
          WebMock.disable_net_connect!
          example.run
        ensure
          WebMock.allow_net_connect!
        end
      end

      let(:client) do
        ConvertkitV4::Client.new(
          access_token: "the-access-token",
          refresh_token: "the-refresh-token",
          client_id: "the-client-id",
          client_secret: "the-client-secret",
          redirect_uri: "https://example.com/callback"
        )
      end
      let(:form_headers) { { "Content-Type" => "application/x-www-form-urlencoded" } }

      it "sends #refresh_token credentials in a form-encoded body" do
        stub = stub_request(:post, "https://app.convertkit.com/oauth/token")
          .with(
            headers: form_headers,
            body: {
              client_id: "the-client-id",
              client_secret: "the-client-secret",
              refresh_token: "the-refresh-token",
              grant_type: "refresh_token"
            }
          )

        client.refresh_token

        expect(stub).to have_been_requested
      end

      it "sends #get_access_token credentials in a form-encoded body" do
        stub = stub_request(:post, "https://app.convertkit.com/oauth/token")
          .with(
            headers: form_headers,
            body: {
              client_id: "the-client-id",
              client_secret: "the-client-secret",
              code: "the-code",
              grant_type: "authorization_code",
              redirect_uri: "https://example.com/callback"
            }
          )

        client.get_access_token("the-code")

        expect(stub).to have_been_requested
      end

      it "sends #revoke_access credentials in a form-encoded body" do
        stub = stub_request(:post, "https://app.convertkit.com/oauth/revoke")
          .with(
            headers: form_headers,
            body: {
              client_id: "the-client-id",
              client_secret: "the-client-secret",
              token: "the-access-token"
            }
          )

        client.revoke_access

        expect(stub).to have_been_requested
      end
    end
  end
end
