module ConvertkitV4
  class Client
    module Webhooks

      def webhooks
        connection.get("webhooks").body
      end

      def create_webhook(url, event)
        response = connection.post("webhooks") do |f|
          f.body = JSON.generate({
            target_url: url,
            event: event
          })
        end
        response.body
      end

    end
  end
end
