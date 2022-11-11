# frozen_string_literal: true

module DatastoreApi
  module Requests
    class CreateApplication
      include Traits::ApiRequest

      attr_reader :payload

      # Instantiate a new application to be created
      #
      # @option payload [Hash] All properties to be sent in the payload
      # @return [DatastoreApi::Requests::CreateApplication] instance
      #
      def initialize(payload:)
        @payload = payload
      end

      # Create a new application
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Responses::ApplicationResult] result response
      #
      def call
        Responses::ApplicationResult.new(
          http_client.post(endpoint, application: payload)
        )
      end

      def endpoint
        '/applications'
      end
    end
  end
end
