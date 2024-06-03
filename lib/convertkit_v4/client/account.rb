module ConvertkitV4
  class Client
    module Account
      def account
        connection.get("account").body
      end
    end
  end
end
