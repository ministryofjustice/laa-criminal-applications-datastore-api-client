# frozen_string_literal: true

module DatastoreApi
  module HealthEngine
    class Engine < ::Rails::Engine
      isolate_namespace DatastoreApi::HealthEngine
      config.root = "#{root}/engines"
    end
  end
end
