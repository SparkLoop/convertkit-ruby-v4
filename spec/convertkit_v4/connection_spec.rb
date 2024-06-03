require "spec_helper"

module ConvertkitV4
  describe Connection do
    describe "#initialize" do
      it "uses access_token" do
        access_token = "access_token"
        connection = Connection.new(access_token: access_token)

        expect(connection.http_connection.params["access_token"]).to eq(access_token)
      end
    end

    describe "error handling" do
      before do
        @connection = Connection.new(access_token: "access_token")
      end

      it "handles 401 errors" do
        stub_request(:get, /.*/).to_return(status: 401)

        expect { @connection.get("account") }.to raise_error(AuthorizationError)
      end

      it "handles 404 errors" do
        stub_request(:get, /.*/).to_return(status: 404)

        expect { @connection.get("account") }.to raise_error(NotFoundError)
      end

      it "handles 422 errors" do
        stub_request(:get, /.*/).to_return(status: 422)

        expect { @connection.get("account") }.to raise_error(UnprocessableEntityError)
      end

      it "handles 429 errors" do
        stub_request(:get, /.*/).to_return(status: 429)

        expect { @connection.get("account") }.to raise_error(TooManyRequestsError)
      end

      it "handles 500 errors" do
        stub_request(:get, /.*/).to_return(status: 500)

        expect { @connection.get("account") }.to raise_error(ServerError)
      end

      it "handles uknown errors" do
        stub_request(:get, /.*/).to_return(status: 403)

        expect { @connection.get("account") }.to raise_error(UnknownError)
      end

      it "handles connection issues" do
        stub_request(:get, /.*/).to_timeout

        expect { @connection.get("account") }.to raise_error(ConnectionError)
      end
    end
  end
end
