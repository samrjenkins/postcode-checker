# frozen_string_literal: true

class LsoaCheck < ApplicationService
  ALLOW_LIST = %w[Lambeth Southwark].freeze

  def initialize(postcode)
    @postcode = postcode
  end

  def call
    lsoa.start_with?(*ALLOW_LIST)
  rescue PostcodeNotFoundError
    true
  end

  private

  attr_reader :postcode

  def lsoa = postcode_data['lsoa']

  def postcode_data = FetchPostcodeData.call(postcode)
end
