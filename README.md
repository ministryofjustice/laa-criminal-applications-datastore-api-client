# Ruby client for the LAA Criminal Applications Datastore

This is a basic little gem to serve as an API client for [laa-criminal-applications-datastore](https://github.com/ministryofjustice/laa-criminal-applications-datastore).

Currently it supports:

* Create an application (submission)
* Get an application by its ID
* Get all application filtered by status, optionally paginated

It will support more operations in the future, as we need them.

## Installation

For now this gem is not being published to rubygems as it is under heavy development so to use it just add 
the following to your Gemfile:

```ruby
gem 'laa-criminal-applications-datastore-api-client', 
    github: 'ministryofjustice/laa-criminal-applications-datastore-api-client'
```

You can lock it to a specific branch or sha if you want too.

## Usage

### Configuration

You need to configure the client before you can use it. You can do this, for example with an initializer:

```ruby
require 'datastore_api'

DatastoreApi.configure do |config|
  config.api_root = ENV.fetch('DATASTORE_API_ROOT', nil)

  config.basic_auth_username = ENV.fetch('DATASTORE_AUTH_USERNAME', nil)
  config.basic_auth_password = ENV.fetch('DATASTORE_AUTH_PASSWORD', nil)
end

````

There are several options you can configure, like open and read timeouts, logging, and more. Please refer to the [Configuration class](lib/datastore_api/configuration.rb) for more details.

### Creating an application

```ruby
response = DatastoreApi::Requests::CreateApplication.new(
  payload: { id: 'uuid', reference: 12345, status: 'submitted', ... }
).call
```

This will return a `Responses::ApplicationResult` class with the API response. A few basic attributes will be mapped to instance attributes. The rest can be obtained with bracket syntax. For example:

```ruby
response.id # "uuid"
response.reference # 12345
response['status'] # "submitted"
```

### Retrieving an application

```ruby
response = DatastoreApi::Requests::GetApplication.new(
  application_id: 'uuid'
).call
```

This, as with the create action, will return a `Responses::ApplicationResult` class.

### Retrieving all applications by status

```ruby
response = DatastoreApi::Requests::ListApplications.new(
  status: :submitted
).call
```

The response is slightly different. It will return a collection of `Responses::ApplicationResult`, but additionally it includes a `#pagination` method to obtain the pagination metadata.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This gem uses rubocop and simplecov (at 100% coverage).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
