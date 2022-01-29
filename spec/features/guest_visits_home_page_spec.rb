require 'rails_helper'

feature 'Guests visits home page' do
  scenario 'viewing default Rails homepage' do
    visit '/'

    expect(page).to have_content 'The Postcode Checker'
  end
end
