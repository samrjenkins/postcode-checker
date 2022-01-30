# frozen_string_literal: true

class AllowedPostcode < ApplicationRecord
  validates :postcode, presence: true, uniqueness: true
end
