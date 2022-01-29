# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits home page' do
  it 'viewing default Rails homepage' do
    visit '/'

    expect(page).to have_content 'The Postcode Checker'
  end
end
