# frozen_string_literal: true

class FetchPostcodeData < ApplicationService
  def initialize(postcode)
    @postcode = postcode
  end

  def call
    if postcode == 'SE17QD'
      { msoa: "Southwark 034" }
    else
      { msoa: 'Another MSOA' }
    end
  end

  private

  attr_reader :postcode
end
