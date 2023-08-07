# frozen_string_literal: true

module DatastoreApi
  module Requests
    module Documents
      class List
        include Traits::ApiRequest

        attr_reader :usn

        # Instantiate a documents listing
        #
        # @param usn [String] Application unique sequence number
        #
        # @raise [ArgumentError] if +usn+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::List] instance
        #
        def initialize(usn:)
          raise ArgumentError, '`usn` cannot be nil' unless usn

          @usn = usn
        end

        # Lists all files
        #
        # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
        # @return [Array[Responses::DocumentResult]] result response
        #
        def call
          http_client.get(endpoint).map do |object|
            Responses::DocumentResult.new(object)
          end
        end

        def endpoint
          format('/documents/%<usn>s', usn:)
        end
      end
    end
  end
end
