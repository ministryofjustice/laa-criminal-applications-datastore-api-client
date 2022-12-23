# frozen_string_literal: true

module DatastoreApi
  module Requests
    class SearchApplications
      include Traits::ApiRequest
      include Traits::PaginatedResponse

      attr_reader :criteria, :pagination

      # Instantiate a new search
      #
      # @option pagination [Hash] Pagination options. Optional
      # @option criteria [Hash] Search criteria
      #
      # @raise [ArgumentError] if no +criteria+ is provided
      # @return [DatastoreApi::Requests::GetApplication] instance
      #
      def initialize(pagination: {}, **criteria)
        raise ArgumentError, 'search criteria is required' unless criteria.any?

        @pagination = pagination
        @criteria = criteria
      end

      # Get a list of applications by criteria, optionally paginated
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Decorators::PaginatedCollection] paginated collection
      #
      def call
        paginated_response(
          http_client.post(endpoint, payload)
        )
      end

      def endpoint
        '/searches'
      end

      private

      def payload
        { search: criteria, pagination: pagination }
      end
    end
  end
end
