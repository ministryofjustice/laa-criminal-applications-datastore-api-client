# frozen_string_literal: true

module DatastoreApi
  module HealthEngine
    class HealthcheckController < ApplicationController
      def show
        healthcheck = DatastoreApi::HealthEngine::GetRequest.call(:health)
        render json: healthcheck.response, status: healthcheck.status
      end

      def ping
        ping = DatastoreApi::HealthEngine::GetRequest.call(:ping)
        render json: ping.response, status: ping.status
      end
    end
  end
end
