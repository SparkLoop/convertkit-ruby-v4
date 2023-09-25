module ConvertkitV4
  class Client
    module Webhooks
      def webhooks
        connection.get("webhooks").body
      end

      def create_webhook(url, events)
        response = connection.post("webhooks") do |f|
          f.params['target_url'] = url
          f.params['event'] = events
        end
        response.body
      end
    end
  end
end
