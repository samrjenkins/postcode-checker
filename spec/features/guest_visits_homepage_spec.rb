# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits homepage' do
  it 'visiting homepage' do
    visit '/'

    expect(page).to have_current_path lsoa_checks_path
  end

  it 'using form to submit postcode in allowed LSOA', cassette: 'SE17QA' do
    Lsoa.create!(name: 'Lambeth')
    visit '/'

    fill_in 'Try a postcode...', with: 'SE17QA'
    click_on 'Go!'

    expect(page).to have_content 'We do service SE17QA 😃'
  end

  it 'submitting empty form' do
    visit '/'

    fill_in 'Try a postcode...', with: ''
    click_on 'Go!'

    expect(page).to have_field 'Try a postcode...'
  end
end
