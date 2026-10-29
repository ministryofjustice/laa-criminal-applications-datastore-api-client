# Ruby client for the LAA Criminal Applications Datastore

This is a basic little gem to serve as an API client for [laa-criminal-applications-datastore](https://github.com/ministryofjustice/laa-criminal-applications-datastore).

Currently it supports:

* Create an application (submission)
* Get an application by its ID
* Get all application filtered by status, optionally paginated
* Update an application by its ID, providing a payload with attributes to update
* Delete an application by its ID

It will support more operations in the future, or extend the existing ones, as we need them.

## Installation

The gem is available on [RubyGems](https://rubygems.org/gems/laa-criminal-applications-datastore-api-client).
Add it to your Gemfile:

```ruby
gem 'laa-criminal-applications-datastore-api-client', '1.3.0',
    require: 'datastore_api'
```

Then run `bundle install`.

## Usage

### Configuration

You need to configure the client before you can use it. You can do this, for example with an initializer:

```ruby
require 'datastore_api'

DatastoreApi.configure do |config|
  config.api_root = ENV.fetch('DATASTORE_API_ROOT', nil)

  config.basic_auth_username = ENV.fetch('DATASTORE_AUTH_USERNAME', nil)
  config.basic_auth_password = ENV.fetch('DATASTORE_AUTH_PASSWORD', nil)

  # You can customise the logger/level, for example:
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::WARN
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

### Other operations

```ruby
# To update an existing application
DatastoreApi::Requests::UpdateApplication.new(
  application_id: 'uuid', payload: { status: :returned }
).call

# To delete an existing application
DatastoreApi::Requests::DeleteApplication.new(
  application_id: 'uuid'
).call

# Search applications, optionally paginated
DatastoreApi::Requests::SearchApplications.new(
  search_text: 'John', 
  pagination: { per_page: 5, page: 2 }
).call

# Health check endpoint
DatastoreApi::Requests::Healthcheck.call
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This gem uses rubocop and simplecov (at 100% coverage).

## Publishing a release

New versions are published to RubyGems manually. Update `DatastoreApi::VERSION` in
`lib/datastore_api/version.rb`, merge the change, and confirm CI has passed for that
commit. Create and push a matching Git tag, such as `v1.3.1`.

Use Ruby 3.3.4 or newer and a RubyGems account with publishing access to this gem and
MFA enabled. If you have not already authenticated on your machine, run:

```sh
gem signin
```

The following example publishes `1.3.1`. Replace the version and tag with the
release you are publishing. Continue to each step only after the previous one
succeeds.

1. Start with a clean working tree, then fetch and check out the release tag:

   ```sh
   git fetch origin tag v1.3.1
   git switch --detach v1.3.1
   ```

2. Check the gem version:

   ```sh
   ruby -r ./lib/datastore_api/version -e 'puts DatastoreApi::VERSION'
   ```

   This must print `1.3.1` for the `v1.3.1` tag. Stop if the version does not match.

3. Build the gem:

   ```sh
   gem build --strict laa-criminal-applications-datastore-api-client.gemspec
   ```

4. Push the generated package to RubyGems and complete any MFA prompt:

   ```sh
   gem push laa-criminal-applications-datastore-api-client-1.3.1.gem --host https://rubygems.org
   ```

5. Confirm the new version appears on the
   [RubyGems page](https://rubygems.org/gems/laa-criminal-applications-datastore-api-client).
   Published versions cannot be overwritten; each release needs a new version.

After publishing, return to your previous branch with `git switch -`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
