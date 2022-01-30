# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits LSOA check page spec' do
  it 'viewing LSOA check page for allowed LSOA', cassette: 'SE17QA' do
    Lsoa.create!(name: 'Lambeth')
    visit '/lsoa_checks/SE17QA'

    expect(page).to have_content 'We do service SE17QA 😃'
  end

  it 'viewing LSOA check page for disallowed LSOA', cassette: 'OX14AJ' do
    Lsoa.create!(name: 'Southwark')
    visit '/lsoa_checks/OX14AJ'

    expect(page).to have_content 'We do not service OX14AJ 😢'
  end

  it 'viewing LSOA check page for invalid postcode', cassette: 'invalid' do
    visit '/lsoa_checks/invalid'

    expect(page).to have_content 'invalid is not a valid postcode 🚨'
  end

  it 'viewing LSOA check page for explicitly allowed postcode' do
    AllowedPostcode.create!(postcode: 'sh241ab')
    visit '/lsoa_checks/SH241AB'

    expect(page).to have_content 'We do service SH241AB 😃'
  end
end
