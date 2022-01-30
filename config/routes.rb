# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/msoa_checks')
  resources :msoa_checks, only: %i[index show create], param: :postcode
end
