# frozen_string_literal: true

module DatastoreApi
  module Responses
    class DocumentResult < SimpleDelegator
      # Just a few basic attributes for quick access
      FIELDS = %w[
        object_key
        size
        last_modified
        url
      ].freeze

      attr_reader(*FIELDS)

      # Instantiate a document result
      #
      # @param response [Hash] The API response for the operation
      # @return [DatastoreApi::Responses::DocumentResult] instance
      #
      def initialize(response)
        FIELDS.each do |field|
          instance_variable_set(:"@#{field}", response[field])
        end

        super
      end
    end
  end
end
