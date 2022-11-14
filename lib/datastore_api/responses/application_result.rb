# frozen_string_literal: true

module DatastoreApi
  module Responses
    class ApplicationResult
      FIELDS = %w[
        id
        usn
        status
        schema_version
        created_at
        submitted_at
        date_stamp
        provider_details
        client_details
        case_details
        interests_of_justice
      ].freeze

      DATE_FIELDS = %w[
        created_at
        submitted_at
        date_stamp
      ].freeze

      attr_reader(*FIELDS)

      alias applicant client_details

      # Instantiate an application result
      #
      # @param response [Hash] The API response for the operation, currently
      #   create an application, or get an existing application by ID
      #
      # @return [DatastoreApi::Responses::ApplicationResult] instance
      #
      def initialize(response)
        FIELDS.each do |field|
          value = response[field]

          instance_variable_set(
            :"@#{field}", parsed_value(field, value)
          )
        end
      end

      private

      def parsed_value(field, value)
        if value.is_a?(String) && DATE_FIELDS.include?(field)
          DateTime.iso8601(value)
        else
          value
        end
      end
    end
  end
end
