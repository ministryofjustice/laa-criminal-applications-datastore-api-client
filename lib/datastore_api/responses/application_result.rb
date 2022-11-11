# frozen_string_literal: true

module DatastoreApi
  module Responses
    class ApplicationResult
      FIELDS = %w[
        id
        status
        version
        created_at
        submitted_at
        date_stamp
        provider_details
        client_details
        case_details
        interests_of_justice
      ].freeze

      attr_reader(*FIELDS)

      # Instantiate an application result
      #
      # @param response [Hash] The API response for the operation, currently
      #   create an application, or get an existing application by ID
      #
      # @return [DatastoreApi::Responses::ApplicationResult] instance
      #
      def initialize(response)
        FIELDS.each do |field|
          instance_variable_set(:"@#{field}", response.fetch(field, nil))
        end
      end
    end
  end
end
