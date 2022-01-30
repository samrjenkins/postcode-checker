# frozen_string_literal: true

class ServicedCheck < ApplicationService
  include PostcodeSanitizer

  def initialize(postcode)
    @postcode = postcode
  end

  def call = allowed_postcode? || in_lsoa?

  private

  attr_reader :postcode

  def allowed_postcode? = AllowedPostcode.exists?(postcode: sanitized_postcode)

  def in_lsoa? = LsoaCheck.call(postcode)
end
