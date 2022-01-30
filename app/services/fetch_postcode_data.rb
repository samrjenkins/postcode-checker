# frozen_string_literal: true

require 'net/http'

class FetchPostcodeData < ApplicationService
  HOST = 'api.postcodes.io'

  def initialize(postcode)
    @postcode = postcode
  end

  def call
    parsed_response['result']
  end

  private

  attr_reader :postcode

  def parsed_response
    JSON.parse json_response
  end

  def json_response
    Net::HTTP.get(HOST, path)
  end

  def path
    "/postcodes/#{postcode}"
  end
end
