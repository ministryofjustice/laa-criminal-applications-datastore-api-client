# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datastore_api/version'

Gem::Specification.new do |spec|
  spec.name     = 'laa-criminal-applications-datastore-api-client'
  spec.version  = DatastoreApi::VERSION

  spec.authors  = ['Jesus Laiz']
  spec.email    = ['zheileman@users.noreply.github.com']

  spec.summary  = 'Ruby client for the LAA Criminal Applications Datastore'
  spec.homepage = 'https://github.com/ministryofjustice/laa-criminal-applications-datastore-api-client'
  spec.license  = 'MIT'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 3.2.1'

  spec.add_runtime_dependency 'faraday', '~> 2.7'
  spec.add_runtime_dependency 'moj-simple-jwt-auth', '~> 0.1.0'
end
