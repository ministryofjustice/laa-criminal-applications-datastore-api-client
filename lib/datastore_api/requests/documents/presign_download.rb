# frozen_string_literal: true

module DatastoreApi
  module Requests
    module Documents
      class PresignDownload
        include Traits::ApiRequest
        include Traits::S3PresignedUrl

        attr_reader :object_key, :s3_opts

        # Instantiate a presigned document download
        #
        # @param object_key [String] The object key to read
        # @param s3_opts [Hash] Additional S3 options, like `expires_in`
        #
        # @raise [ArgumentError] if +object_key+ is missing or +nil+
        #
        # @return [DatastoreApi::Requests::Documents::PresignDownload] instance
        #
        def initialize(object_key:, **s3_opts)
          raise ArgumentError, '`object_key` cannot be nil' unless object_key

          @object_key = object_key
          @s3_opts = s3_opts
        end

        def action
          'presign_download'
        end
      end
    end
  end
end
