module ConvertkitV4
  class Configuration
    attr_accessor :client_id, :client_secret, :redirect_uri, :access_token, :refresh_token
    attr_accessor :timeout, :open_timeout

    def initialize
      @timeout = 30
      @open_timeout = 5
    end
  end
end
