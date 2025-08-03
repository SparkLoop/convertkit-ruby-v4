module ConvertkitV4
  class Client
    module Subscribers

      def subscribers(options = {})
        connection.get("subscribers", options).body
      end

      def subscriber(subscriber_id)
        connection.get("subscribers/#{subscriber_id}").body["subscriber"]
      end

      def add_subscriber(email_address, options = {})
        response = connection.post("subscribers") do |f|
          body = {
            email_address: email_address
          }

          body[:fields] = options[:fields] if options[:fields]
          body[:first_name] = options[:first_name] if options[:first_name]

          f.body = JSON.generate(body)
        end
        response.body["subscriber"]
      end

      def update_subscriber(subscriber_id, options = {})
        response = connection.put("subscribers/#{subscriber_id}") do |f|
          body = {}
          body[:email_address] = options[:email_address] if options[:email_address]
          body[:fields] = options[:fields] if options[:fields]
          body[:first_name] = options[:first_name] if options[:first_name]

          f.body = JSON.generate(body)
        end
        response.body["subscriber"]
      end

      def unsubscribe(subscriber_id)
        connection.post("subscribers/#{subscriber_id}/unsubscribe")
      end

      def subscriber_tags(subscriber_id)
        connection.get("subscribers/#{subscriber_id}/tags").body["tags"]
      end

      # returns an hash with the following keys:
      # {
      #   "subscriber": {
      #     "id": 3436990966,
      #     "stats": {
      #       "sent": 2,
      #       "opened": 2,
      #       "clicked": 2,
      #       "bounced": 0,
      #       "open_rate": 1,
      #       "click_rate": 1,
      #       "last_sent": "2025-06-25 16:44:37.000",
      #       "last_opened": "2025-06-25 16:45:36.000",
      #       "last_clicked": "2025-06-25 16:45:42.000",
      #       "sent_since_last_open": 0,
      #       "sent_since_last_click": 0
      #     }
      #   }
      # }
      def subscriber_stats(subscriber_id)
        connection.get("subscribers/#{subscriber_id}/stats").body["subscriber"]
      end
    end
  end
end
