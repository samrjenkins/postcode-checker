# frozen_string_literal: true

require 'net/http'

class FetchPostcodeData < ApplicationService
  HOST = 'api.postcodes.io'

  def initialize(postcode)
    @postcode = postcode
  end

  def call = parsed_response['result']

  private

  attr_reader :postcode

  def parsed_response = JSON.parse json_response

  def json_response = Net::HTTP.get(HOST, path)

  def path = "/postcodes/#{sanitized_postcode}"

  def sanitized_postcode = postcode.downcase.gsub(' ', '')
end
