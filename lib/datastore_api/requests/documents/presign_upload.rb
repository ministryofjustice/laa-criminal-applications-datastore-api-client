# frozen_string_literal: true

module DatastoreApi
  module Requests
    module Documents
      class PresignUpload
        include Traits::ApiRequest
        include Traits::S3PresignedUrl

        attr_reader :usn, :filename, :s3_opts

        # Instantiate a presigned document upload
        #
        # @param usn [Integer] Application unique sequence number
        # @param s3_opts [Hash] Additional S3 options, like `expires_in`
        #
        # @raise [ArgumentError] if +usn+ is missing or +nil+
        # @raise [ArgumentError] if +filename+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::PresignUpload] instance
        #
        def initialize(usn:, filename:, **s3_opts)
          raise ArgumentError, '`usn` cannot be nil' unless usn
          raise ArgumentError, '`filename` cannot be nil' unless filename

          @usn = usn
          @filename = filename
          @s3_opts = s3_opts
        end

        def action
          'presign_upload'
        end

        private

        def object_key
          [usn, filename].join('/')
        end
      end
    end
  end
end
