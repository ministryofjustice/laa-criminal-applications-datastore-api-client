# frozen_string_literal: true

require 'delegate'

module DatastoreApi
  module Decorators
    class PaginatedCollection < SimpleDelegator
      attr_reader :pagination

      def initialize(collection, pagination)
        @pagination = pagination

        super(collection)
      end
    end
  end
end
