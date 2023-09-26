module ConvertkitV4
  class Client
    module Tags
      def tags
        connection.get("tags")
      end

      def add_subscriber_to_tag(tag_id, options = {})
        connection.post("tags/#{tag_id}/subscribers") do |f|
          f.body = JSON.generate({
            email_address: options[:email],
            id: options[:id]
          })
        end
      end

      def remove_tag_from_subscriber(tag_id, subscriber_id)
        connection.delete("subscribers/#{subscriber_id}/tags/#{tag_id}")
      end

      def remove_tag_from_subscriber_by_email(tag_id, email)
        connection.post("tags/#{tag_id}/unsubscribe") do |f|
          f.body = JSON.generate({
            email: email
          })
        end
      end

      def create_tag(tag_name)
        response = connection.post("tags") do |f|
          f.body = JSON.generate({
            tag: {
              name: tag_name
            }
          })
        end
        response.body
      end
    end
  end
end
