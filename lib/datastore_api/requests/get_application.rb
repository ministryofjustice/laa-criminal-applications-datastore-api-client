# frozen_string_literal: true

module DatastoreApi
  module Requests
    class GetApplication
      include Traits::ApiRequest

      attr_reader :application_id

      # Instantiate a get application request
      #
      # @param application_id [String] The application UUID to retrieve
      #
      # @raise [ArgumentError] if +application_id+ is missing or +nil+
      # @return [DatastoreApi::Requests::GetApplication] instance
      #
      def initialize(application_id:)
        raise ArgumentError, '`application_id` cannot be nil' unless application_id

        @application_id = application_id
      end

      # Get existing application details
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Responses::ApplicationResult] result response
      #
      def call
        Responses::ApplicationResult.new(
          http_client.get(endpoint)
        )
      end

      def endpoint
        format(
          '/applications/%<application_id>s', application_id:
        )
      end
    end
  end
end
