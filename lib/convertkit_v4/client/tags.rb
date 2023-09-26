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
        response.body
      end

      def add_subscriber_to_tag(tag_id, options = {})
        response = connection.post("tags/#{tag_id}/subscribers") do |f|
          f.body = JSON.generate({
            email: options[:email],
            id: options[:id]
          })
        end
        response.body
      end

    end
  end
end
