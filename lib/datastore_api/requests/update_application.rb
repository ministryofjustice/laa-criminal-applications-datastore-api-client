# frozen_string_literal: true

module DatastoreApi
  module Requests
    class UpdateApplication
      include Traits::ApiRequest

      attr_reader :application_id, :payload, :member

      # Instantiate a new application to be updated
      #
      # @param application_id [String] The application UUID to retrieve
      # @param payload [Hash] All properties to be sent in the payload
      # @param member [Symbol] Member route. Optional
      #
      # @raise [ArgumentError] if +application_id+ is missing or +nil+
      # @raise [ArgumentError] if +payload+ is missing or +nil+
      #
      # @return [DatastoreApi::Requests::UpdateApplication] instance
      #
      def initialize(application_id:, payload:, member: nil)
        raise ArgumentError, '`application_id` cannot be nil' unless application_id
        raise ArgumentError, '`payload` cannot be nil' unless payload

        @application_id = application_id
        @payload = payload
        @member = member
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
          '/applications/%<resource_path>s', resource_path: resource_path
        )
      end

      private

      def resource_path
        [application_id, member].compact.join('/')
      end
    end
  end
end
