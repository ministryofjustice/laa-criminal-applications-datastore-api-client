# frozen_string_literal: true

module DatastoreApi
  module HealthEngine
    class GetRequest
      attr_reader :action, :response, :status

      def initialize(action)
        @action = action
      end
      private_class_method :new

      def self.call(action)
        new(action).call
      end

      def call
        do_request
        self
      end

      private

      def do_request
        res = Faraday.get(endpoint)

        @status = res.success? ? :ok : :service_unavailable
        @response = JSON.parse(res.body)
      rescue StandardError => e
        @status = :service_unavailable
        @response = { error: e.message }
      end

      def endpoint
        [DatastoreApi.configuration.api_root, action].join('/')
      end
    end
  end
end
