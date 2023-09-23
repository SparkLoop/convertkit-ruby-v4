module ConvertkitV4
  class Client
    module Sequences
      def sequences
        connection.get("sequences")
      end

      def add_subscriber_to_sequence(sequence_id, email, options = {})
        connection.post("sequences/#{sequence_id}/subscribe") do |f|
          f.params['email'] = email
          f.params['first_name'] = options[:first_name]
          f.params['fields'] = options[:fields]
          f.params['tags'] = options[:tags]
        end
      end
    end
  end
end
