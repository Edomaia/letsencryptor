# frozen_string_literal: true

module Letsencryptor
  module Heroku
    class Client
      attr_reader :app_name, :client

      def initialize(app_name)
        @app_name = app_name
        initialize_client
      end

      private

      def initialize_client
        @client = PlatformAPI.connect_oauth(token)
      end

      def token
        ENV.fetch('HEROKU_PLATFORM_TOKEN', nil)
      end
    end
  end
end
