require "spec_helper"

module ConvertkitV4
  class Client
    describe Account do
      before do
        @client = ConvertkitV4::Client.new
      end

      describe "#account" do
        it "fetches account information" do
          VCR.use_cassette "account" do
            @account = @client.account

            expect(@account["primary_email_address"]).to be_truthy
          end
        end
      end
    end
  end
end
