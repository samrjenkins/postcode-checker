# frozen_string_literal: true

class Lsoa < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
