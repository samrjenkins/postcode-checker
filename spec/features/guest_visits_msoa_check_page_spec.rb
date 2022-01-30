# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits MSOA check page spec' do
  it 'viewing MSOA check page for Lambeth postcode', cassette: 'SE17QA' do
    visit '/msoa_checks/SE17QA'

    expect(page).to have_content 'SE17QA is in the MSOA 👍'
  end

  it 'viewing MSOA check page for Southwark postcode', cassette: 'SE17QD' do
    visit '/msoa_checks/SE17QD'

    expect(page).to have_content 'SE17QD is in the MSOA 👍'
  end

  it 'viewing MSOA check page for neither Lambeth nor Southwark postcode', cassette: 'OX14AJ' do
    visit '/msoa_checks/OX14AJ'

    expect(page).to have_content 'OX14AJ is not in the MSOA 👎'
  end

  it 'viewing MSOA check page for invalid postcode', cassette: 'invalid' do
    visit '/msoa_checks/invalid'

    expect(page).to have_content 'invalid is not a valid postcode'
  end
end
