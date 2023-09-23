require "convertkit_v4/errors"
require "faraday"
require "faraday_middleware"
require "json"

module ConvertkitV4
  class Connection
    attr_reader :http_connection

    API_URL = "https://api.convertkit.com/"
    API_VERSION_PATH = "alpha/"

    def initialize(access_token: nil)
      @http_connection = faraday_connection(access_token)
    end

    def content_type
      "application/json"
    end

    def get(*args, &blk)
      request(:get, *args, &blk)
    end

    def post(*args, &blk)
      request(:post, *args, &blk)
    end

    def put(*args, &blk)
      request(:put, *args, &blk)
    end

    def delete(*args, &blk)
      request(:delete, *args, &blk)
    end

    private

    def faraday_connection(access_token)
      Faraday.new do |f|
        f.url_prefix = "#{API_URL}#{API_VERSION_PATH}"
        f.adapter :net_http

        f.options.timeout = ConvertkitV4.configuration.timeout
        f.options.open_timeout = ConvertkitV4.configuration.open_timeout

        f.headers['Content-Type'] = content_type
        f.headers['Accept'] = "*/*"

        f.params['access_token'] = access_token if access_token

        f.response :json, content_type: /\bjson$/
      end
    end

    def request(method, *args, &blk)
      begin
        response = http_connection.public_send(method, *args, &blk)
      rescue Faraday::Error => e
        raise ConnectionError.new(e)
      end

      unless response.success?
        handle_error_response(response)
      end

      response
    end

    def handle_error_response(response)
      case response.status
      when 401
        raise AuthorizationError.new(response.body)
      when 404
        raise NotFoundError.new(response.body)
      when 422
        raise UnprocessableEntityError.new(response.body)
      when 429
        raise TooManyRequestsError.new(response.body)
      when 500..599
        raise ServerError.new(response.body)
      else
        raise UnknownError.new(response.body)
      end
    end
  end
end
