# frozen_string_literal: true

require 'json'
require 'logger'

require_relative 'datastore_api/version'
require_relative 'datastore_api/configuration'
require_relative 'datastore_api/errors'
require_relative 'datastore_api/http_client'

require_relative 'datastore_api/decorators/paginated_collection'

require_relative 'datastore_api/traits/api_request'
require_relative 'datastore_api/traits/paginated_response'
require_relative 'datastore_api/traits/s3_presigned_url'

require_relative 'datastore_api/requests/healthcheck'
require_relative 'datastore_api/requests/create_application'
require_relative 'datastore_api/requests/get_application'
require_relative 'datastore_api/requests/list_applications'
require_relative 'datastore_api/requests/search_applications'
require_relative 'datastore_api/requests/update_application'
require_relative 'datastore_api/requests/delete_application'

require_relative 'datastore_api/requests/documents/list'
require_relative 'datastore_api/requests/documents/delete'
# require_relative 'datastore_api/requests/documents/upload'
require_relative 'datastore_api/requests/documents/presign_upload'
require_relative 'datastore_api/requests/documents/presign_download'

require_relative 'datastore_api/responses/document_result'
require_relative 'datastore_api/responses/application_result'
require_relative 'datastore_api/responses/healthcheck_result'

require_relative '../engines/health_engine' if defined?(Rails)

module DatastoreApi
end
