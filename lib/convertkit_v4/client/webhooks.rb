module ConvertkitV4
  class Client
    module Webhooks
      def webhooks
        connection.get("webhooks").body
      end

      def create_webhook(target_url, event)
        response = connection.post("webhooks") do |f|
          f.body = JSON.generate({
            target_url: target_url,
            event: event
          })
        end
        response.body
      end
    end
  end
end
