# frozen_string_literal: true

require 'net/http'

class FetchPostcodeData < ApplicationService
  include PostcodeSanitizer

  HOST = 'api.postcodes.io'

  def initialize(postcode)
    @postcode = postcode
  end

  def call
    return parsed_response['result'] if success?

    raise error_class
  end

  private

  attr_reader :postcode

  def success? = status == 200

  def status = parsed_response['status']

  def parsed_response
    @parsed_response ||= JSON.parse json_response
  end

  def json_response = Net::HTTP.get(HOST, path)

  def path = "/postcodes/#{sanitized_postcode}"

  def error_class
    "#{error_message} error".titleize.gsub(' ', '').constantize
  rescue NameError
    InvalidPostcodeError
  end

  def error_message = parsed_response['error']
end
