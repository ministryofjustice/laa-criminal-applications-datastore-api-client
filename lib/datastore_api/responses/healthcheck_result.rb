# frozen_string_literal: true

module DatastoreApi
  module Responses
    class HealthcheckResult < SimpleDelegator
      FIELDS = %w[
        status
        error
      ].freeze

      attr_reader(*FIELDS)

      # Instantiate a health check result
      #
      # @param response [Hash] The API response for the operation
      # @return [DatastoreApi::Responses::HealthcheckResult] instance
      #
      def initialize(response)
        FIELDS.each do |field|
          instance_variable_set(:"@#{field}", response[field])
        end

        super
      end

      def success?
        error.nil?
      end

      def error?
        !success?
      end
    end
  end
end
