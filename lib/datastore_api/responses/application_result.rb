# frozen_string_literal: true

module DatastoreApi
  module Responses
    class ApplicationResult < SimpleDelegator
      # Just a few basic attributes for quick access
      FIELDS = %w[
        id
        status
        reference
        schema_version
      ].freeze

      attr_reader(*FIELDS)

      # Instantiate an application result
      #
      # @param response [Hash] The API response for the operation
      # @return [DatastoreApi::Responses::ApplicationResult] instance
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
