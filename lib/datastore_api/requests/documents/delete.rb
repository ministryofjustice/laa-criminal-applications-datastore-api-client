# frozen_string_literal: true

require 'base64'

module DatastoreApi
  module Requests
    module Documents
      class Delete
        include Traits::ApiRequest

        attr_reader :object_key

        # Instantiate a document deletion
        #
        # @param object_key [String] The object key to delete
        #
        # @raise [ArgumentError] if +object_key+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::Delete] instance
        #
        def initialize(object_key:)
          raise ArgumentError, '`object_key` cannot be nil' unless object_key

          @object_key = object_key
        end

        # Delete a file
        #
        # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
        # @return [Responses::DocumentResult] result response
        #
        def call
          Responses::DocumentResult.new(
            http_client.delete(endpoint)
          )
        end

        def endpoint
          format(
            '/documents/%<encoded_object_key>s', encoded_object_key:
          )
        end

        private

        def encoded_object_key
          CGI.escape(
            Base64.strict_encode64(object_key)
          )
        end
      end
    end
  end
end
