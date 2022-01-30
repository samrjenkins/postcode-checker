# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/lsoa_checks')
  resources :lsoa_checks, only: %i[index show create], param: :postcode
end
