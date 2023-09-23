require "convertkit_v4/client/account"
require "convertkit_v4/client/custom_fields"
require "convertkit_v4/client/forms"
require "convertkit_v4/client/sequences"
require "convertkit_v4/client/subscribers"
require "convertkit_v4/client/webhooks"
require "convertkit_v4/client/tags"
require "convertkit_v4/connection"

module ConvertkitV4
  class Client
    include Account
    include CustomFields
    include Forms
    include Sequences
    include Subscribers
    include Webhooks
    include Tags

    attr_accessor :access_token, :refresh_token, :client_id, :client_secret, :redirect_uri

    AUTH_URL = "https://app.convertkit.com/oauth/authorize"
    ACCESS_TOKEN_URL = "https://app.convertkit.com/oauth/token"
    REVOKE_ACCESS_URL = "https://app.convertkit.com/oauth/revoke"

    def initialize(access_token: nil, refresh_token: nil, client_id: nil, client_secret: nil, redirect_uri: nil)
      @access_token = access_token
      @refresh_token = refresh_token

      @client_id = client_id || ConvertkitV4.configuration.client_id
      @client_secret = client_secret || ConvertkitV4.configuration.client_secret
      @redirect_uri = redirect_uri || ConvertkitV4.configuration.redirect_uri
    end

    def connection
      @connection ||= Connection.new(access_token: @access_token)
    end

    def authorize
      Faraday.new(url: AUTH_URL).get do |req|
        req.headers["Content-Type"] = "application/json"
        req.params = { client_id: @client_id, redirect_uri: @redirect_uri }
      end
    end

    def get_access_token(code)
      Faraday.new(url: ACCESS_TOKEN_URL).post do |req|
        req.headers["Content-Type"] = "application/json"
        req.params = {
          client_id: @client_id,
          client_secret: @client_secret,
          code: code,
          grant_type: "authorization_code",
          redirect_uri: @redirect_uri
        }
      end
    end

    def refresh_token
      Faraday.new(url: ACCESS_TOKEN_URL).post do |req|
        req.headers["Content-Type"] = "application/json"
        req.params = {
          client_id: @client_id,
          client_secret: @client_secret,
          refresh_token: @refresh_token,
          grant_type: "refresh_token"
        }
      end
    end

    def revoke_access
      Faraday.new(url: REVOKE_ACCESS_URL).post do |req|
        req.headers["Content-Type"] = "application/json"
        req.params = {
          client_id: @client_id,
          client_secret: @client_secret,
          token: @access_token
        }
      end
    end
  end
end
