# frozen_string_literal: true

class MsoaCheck < ApplicationService
  ALLOW_LIST = %w[Lambeth Southwark].freeze

  def initialize(postcode)
    @postcode = postcode
  end

  def call
    msoa.start_with? *ALLOW_LIST
  end

  private

  attr_reader :postcode

  def msoa
    postcode_data[:msoa]
  end

  def postcode_data
    FetchPostcodeData.call(postcode)
  end
end
