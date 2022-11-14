# frozen_string_literal: true

module DatastoreApi
  module Traits
    module PaginatedResponse
      PAGINATION_OBJECT = 'pagination'
      RESULTS_OBJECT = 'records'

      def paginated_response(response, result_class: Responses::ApplicationResult)
        results = response.fetch(RESULTS_OBJECT, []).map do |object|
          result_class.new(object)
        end

        pagination = response.fetch(PAGINATION_OBJECT, {})

        Decorators::PaginatedCollection.new(results, pagination)
      end
    end
  end
end
