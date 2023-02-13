# frozen_string_literal: true

module DatastoreApi
  class Configuration
    attr_accessor :logger,
                  :api_root,
                  :api_path,
                  :auth_type,
                  :basic_auth_username,
                  :basic_auth_password,
                  :open_timeout,
                  :read_timeout,
                  :request_headers,
                  :http_client_class

    def initialize
      @api_path = '/api/v1'

      # Defaults to `basic` for backwards compatibility
      # but in a future release of the gem this will be `nil`
      @auth_type = :basic

      @open_timeout = 10   # connection timeout in seconds
      @read_timeout = 20   # read timeout in seconds

      @request_headers = {
        'User-Agent' => "laa-criminal-applications-datastore-api-client v#{DatastoreApi::VERSION}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }.freeze

      @http_client_class = DatastoreApi::HttpClient
    end
  end

  # Get current configuration
  #
  # @return [DatastoreApi::Configuration] current configuration
  #
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Configure the client
  #
  # Any attributes listed in +attr_accessor+ can be configured
  #
  # +api_path+, +open_timeout+, +read_timeout+ and +http_client_class+
  #   are set to sensible defaults already, but still can be changed
  #
  # +request_headers+ can also be changed or configured, but it is not
  #   recommended unless you know what you are doing
  #
  # @example
  #   DatastoreApi.configure do |config|
  #     config.basic_auth_username = 'username'
  #     config.basic_auth_password = 'password'
  #   end
  #
  def self.configure
    yield configuration
  end
end
