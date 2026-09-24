module ConvertkitV4
  class Client
    module Broadcasts

      def broadcasts(options = {})
        connection.get("broadcasts", options).body["broadcasts"]
      end

      def broadcast(broadcast_id)
        connection.get("broadcasts/#{broadcast_id}").body["broadcast"]
      end

      def broadcast_stats(broadcast_id)
        connection.get("broadcasts/#{broadcast_id}/stats").body["broadcast"]
      end

    end
  end
end
