# frozen_string_literal: true

module DatastoreApi
  module Requests
    module Documents
      class PresignUpload
        include Traits::ApiRequest
        include Traits::S3PresignedUrl

        attr_reader :usn, :s3_opts

        # Instantiate a presigned document upload
        #
        # @param usn [Integer] Application unique sequence number
        # @param s3_opts [Hash] Additional S3 options, like `expires_in`
        #
        # @raise [ArgumentError] if +usn+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::PresignUpload] instance
        #
        def initialize(usn:, **s3_opts)
          raise ArgumentError, '`usn` cannot be nil' unless usn

          @usn = usn
          @s3_opts = s3_opts
        end

        def action
          'presign_upload'
        end

        def object_key
          [usn, filename].join('/')
        end

        private

        def filename
          @filename ||= SecureRandom.alphanumeric(10)
        end
      end
    end
  end
end
