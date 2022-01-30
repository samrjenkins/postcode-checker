# frozen_string_literal: true

module PostcodeSanitizer
  private

  def sanitized_postcode = postcode.downcase.gsub(' ', '')
end
