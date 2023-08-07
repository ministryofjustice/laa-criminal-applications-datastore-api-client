# frozen_string_literal: true

module DatastoreApi
  module Traits
    module S3PresignedUrl
      # Get a presigned URL
      #
      # @raise [DatastoreApi::Errors::ApiError] refer to lib/datastore_api/errors.rb
      # @return [Responses::DocumentResult] result response
      #
      def call
        Responses::DocumentResult.new(
          http_client.put(endpoint, payload)
        )
      end

      def endpoint
        format('/documents/%<action>s', action:)
      end

      # :nocov:
      def action
        raise 'implement in classes that include this trait module'
      end

      def object_key
        raise 'implement in classes that include this trait module'
      end
      # :nocov:

      private

      def payload
        { object_key:, s3_opts: }
      end
    end
  end
end
