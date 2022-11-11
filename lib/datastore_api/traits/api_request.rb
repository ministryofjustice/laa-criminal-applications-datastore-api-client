# frozen_string_literal: true

module DatastoreApi
  module Traits
    module ApiRequest
      # :nocov:
      def call
        raise 'implement in subclasses'
      end

      def endpoint
        raise 'implement in subclasses'
      end
      # :nocov:

      private

      def http_client
        @_http_client ||= DatastoreApi.configuration.http_client_class.new
      end
    end
  end
end
