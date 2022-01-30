# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.before(:example, :cassette) do |example|
    expect(Net::HTTP)
      .to receive(:get)
      .with('api.postcodes.io', "/postcodes/#{example.metadata[:cassette].downcase.gsub(' ', '')}")
      .and_call_original
  end

  config.around(:example, :cassette) do |example|
    VCR.use_cassette example.metadata[:cassette].downcase.gsub(' ', ''), allow_unused_http_interactions: false do
      example.run
    end
  end
end
