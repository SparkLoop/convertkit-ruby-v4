module ConvertkitV4
  class Client
    module CustomFields

      def custom_fields
        connection.get("custom_fields").body["custom_fields"]
      end

      def add_custom_field(label)
        response = connection.post("custom_fields") do |f|
          f.body = JSON.generate({
            label: label
          })
        end
        response.body["custom_field"]
      end

      def delete_custom_field(custom_field_id)
        connection.delete("custom_fields/#{custom_field_id}")
      end

      def update_custom_field(custom_field_id, label)
        response = connection.put("custom_fields/#{custom_field_id}") do |f|
          f.body = JSON.generate({
            label: label
          })
        end
        response.body["custom_field"]
      end

    end
  end
end
