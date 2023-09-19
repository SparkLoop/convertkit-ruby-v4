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

    attr_accessor :api_secret, :api_key

    def initialize( api_key=nil, api_secret=nil )
      @api_secret = api_secret || ConvertkitV4.configuration.api_secret
      @api_key = api_key || ConvertkitV4.configuration.api_key
    end

    def connection
      @connection ||= Connection.new(api_key: api_key, api_secret: api_secret)
    end
  end
end
