module ConvertkitV4
  class Client
    module Tags

      def tags
        connection.get("tags").body["tags"]
      end

      def create_tag(tag_name)
        response = connection.post("tags") do |f|
          f.body = JSON.generate({
            name: tag_name
          })
        end
        response.body["tag"]
      end

      # The subscriber must already exist in Kit; create it first with #add_subscriber.
      def add_subscriber_to_tag(tag_id, email_address)
        response = connection.post("tags/#{tag_id}/subscribers") do |f|
          f.body = JSON.generate({
            email_address: email_address
          })
        end
        response.body
      end

    end
  end
end
