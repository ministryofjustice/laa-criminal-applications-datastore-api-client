# frozen_string_literal: true

module DatastoreApi
  module Errors
    def raise_error!(response_body, status_code)
      message = response_body.merge('http_code' => status_code)

      case status_code
      when 400 then raise BadRequest, message
      when 401 then raise Unauthorized, message
      when 404 then raise NotFoundError, message
      when 409 then raise ConflictError, message
      when 422 then raise InvalidRequest, message
      when 500 then raise ServerError, message
      else
        raise ApiError, message
      end
    end

    class ApiError < StandardError; end

    class ClientError < ApiError; end
    class ServerError < ApiError; end
    class ConnectionError < ApiError; end

    class BadRequest < ClientError; end
    class NotFoundError < ClientError; end
    class InvalidRequest < ClientError; end
    class Unauthorized < ClientError; end
    class ConflictError < ClientError; end
  end
end
