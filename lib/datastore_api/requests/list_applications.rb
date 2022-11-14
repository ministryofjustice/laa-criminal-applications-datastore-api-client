# frozen_string_literal: true

module DatastoreApi
  module Requests
    class ListApplications
      include Traits::ApiRequest
      include Traits::PaginatedResponse

      attr_reader :status, :query_params

      # Instantiate a list applications request
      #
      # @param status [String] Filter by application status
      # @param query_params [Hash] Additional query params, including pagination options
      #
      # @raise [ArgumentError] if +status+ is missing or +nil+
      # @return [DatastoreApi::Requests::GetApplication] instance
      #
      def initialize(status:, **query_params)
        raise ArgumentError, '`status` cannot be nil' unless status

        @status = status
        @query_params = query_params
      end

      # Get a list of applications filtered by status, optionally paginated
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Decorators::PaginatedCollection] paginated collection
      #
      def call
        paginated_response(
          http_client.get(endpoint, query)
        )
      end

      def endpoint
        '/applications'
      end

      private

      def query
        { status: status }.merge(query_params)
      end
    end
  end
end
