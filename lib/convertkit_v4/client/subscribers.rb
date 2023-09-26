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
        connection.post("unsubscribe") do |f|
          f.body = JSON.generate({
            id: subscriber_id
          })
        end
      end

      def subscriber_tags(subscriber_id)
        connection.get("subscribers/#{subscriber_id}/tags").body["tags"]
      end
    end
  end
end
