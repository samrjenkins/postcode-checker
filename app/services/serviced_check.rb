# frozen_string_literal: true

class ServicedCheck < ApplicationService
  def initialize(postcode)
    @postcode = postcode
  end

  def call
    allowed_postcode? || in_lsoa?
  end

  private

  attr_reader :postcode

  def allowed_postcode?
    %w[sh241aa sh241ab].include? postcode.downcase.gsub(' ', '')
  end

  def in_lsoa? = LsoaCheck.call(postcode)
end
