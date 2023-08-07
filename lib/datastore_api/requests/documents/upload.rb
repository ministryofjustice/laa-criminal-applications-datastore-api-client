# frozen_string_literal: true

module DatastoreApi
  module Requests
    module Documents
      class Upload
        include Traits::ApiRequest

        attr_reader :usn, :file, :options

        # Instantiate a new document upload
        #
        # @param usn [String] Application unique sequence number
        # @param file [File] The file object
        # @param options [Hash] Additional options, like `filename`
        #
        # @raise [ArgumentError] if +usn+ is missing or +nil+
        # @raise [ArgumentError] if +file+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::Upload] instance
        #
        def initialize(usn:, file:, **options)
          raise ArgumentError, '`usn` cannot be nil' unless usn
          raise ArgumentError, '`file` cannot be nil' unless file

          @usn = usn
          @file = file
          @options = options
        end

        # Upload a file
        #
        # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
        # @return [Responses::DocumentResult] result response
        #
        def call
          Responses::DocumentResult.new(
            http_client.post(endpoint, payload, { multipart: true })
          )
        end

        def endpoint
          format('/documents/%<usn>s', usn:)
        end

        private

        def payload
          { file: }.merge(payload: JSON.dump(options))
        end
      end
    end
  end
end
