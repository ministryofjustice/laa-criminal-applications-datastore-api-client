# frozen_string_literal: true

DatastoreApi::HealthEngine::Engine.routes.draw do
  get :health, to: 'healthcheck#show'
  get :ping,   to: 'healthcheck#ping'
end
