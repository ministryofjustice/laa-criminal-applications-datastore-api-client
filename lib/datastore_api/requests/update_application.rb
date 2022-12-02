# frozen_string_literal: true

module DatastoreApi
  module Requests
    class UpdateApplication
      include Traits::ApiRequest

      attr_reader :application_id, :payload

      # Instantiate a new application to be updated
      #
      # @param application_id [String] The application UUID to retrieve
      # @param payload [Hash] All properties to be sent in the payload
      #
      # @raise [ArgumentError] if +application_id+ is missing or +nil+
      # @raise [ArgumentError] if +payload+ is missing or +nil+
      #
      # @return [DatastoreApi::Requests::UpdateApplication] instance
      #
      def initialize(application_id:, payload:)
        raise ArgumentError, '`application_id` cannot be nil' unless application_id
        raise ArgumentError, '`payload` cannot be nil' unless payload

        @application_id = application_id
        @payload = payload
      end

      # Update an existing application
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Responses::ApplicationResult] result response
      #
      def call
        Responses::ApplicationResult.new(
          http_client.put(endpoint, payload)
        )
      end

      def endpoint
        format(
          '/applications/%<application_id>s', application_id: application_id
        )
      end
    end
  end
end
