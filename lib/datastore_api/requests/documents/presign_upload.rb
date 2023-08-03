# frozen_string_literal: true

module DatastoreApi
  module Requests
    module Documents
      class PresignUpload
        include Traits::ApiRequest
        include Traits::S3PresignedUrl

        attr_reader :usn, :application_id, :filename, :s3_opts

        # Instantiate a presigned document upload
        #
        # @param usn [Integer] Application unique sequence number
        # @param application_id [String] Application UUID
        # @param s3_opts [Hash] Additional S3 options, like `expires_in`
        #
        # @raise [ArgumentError] if +usn+ is missing or +nil+
        # @raise [ArgumentError] if +application_id+ is missing or +nil+
        # @raise [ArgumentError] if +filename+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::PresignUpload] instance
        #
        def initialize(usn:, application_id:, filename:, **s3_opts)
          raise ArgumentError, '`usn` cannot be nil' unless usn
          raise ArgumentError, '`application_id` cannot be nil' unless application_id
          raise ArgumentError, '`filename` cannot be nil' unless filename

          @usn = usn
          @application_id = application_id
          @filename = filename
          @s3_opts = s3_opts
        end

        def action
          'presign_upload'
        end

        private

        def object_key
          [
            usn,
            application_id,
            filename
          ].join('/')
        end
      end
    end
  end
end
