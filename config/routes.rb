# frozen_string_literal: true

Rails.application.routes.draw do
  resources :msoa_checks, only: :show, param: :postcode
end
