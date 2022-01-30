# frozen_string_literal: true

require 'net/http'

class FetchPostcodeData < ApplicationService
  HOST = 'api.postcodes.io'

  def initialize(postcode)
    @postcode = postcode
  end

  def call
    case status
    when 200
      parsed_response['result']
    when 404
      raise_error
    end
  end

  private

  attr_reader :postcode

  def status = parsed_response['status']

  def raise_error
    raise error_class
  end

  def parsed_response
    @parsed_response ||= JSON.parse json_response
  end

  def json_response = Net::HTTP.get(HOST, path)

  def path = "/postcodes/#{sanitized_postcode}"

  def sanitized_postcode = postcode.downcase.gsub(' ', '')

  def error_class
    "#{error_message} error".titleize.gsub(' ', '').constantize
  end

  def error_message = parsed_response['error']
end
