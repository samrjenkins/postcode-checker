# frozen_string_literal: true

class LsoaCheck < ApplicationService
  def initialize(postcode)
    @postcode = postcode
  end

  def call
    lsoa.start_with?(*allow_list)
  rescue PostcodeNotFoundError
    false
  end

  private

  attr_reader :postcode

  def lsoa = postcode_data['lsoa']

  def postcode_data = FetchPostcodeData.call(postcode)

  def allow_list = Lsoa.pluck(:name)
end
