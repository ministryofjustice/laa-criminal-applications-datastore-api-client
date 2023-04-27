# frozen_string_literal: true

module DatastoreApi
  module Requests
    class Healthcheck
      include Traits::ApiRequest

      def self.call
        new.call
      end

      # Get a health check result
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Responses::HealthcheckResult] result response
      #
      def call
        Responses::HealthcheckResult.new(
          http_client.get(endpoint)
        )
      end

      def endpoint
        '/health'
      end
    end
  end
end
