# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits LSOA check page spec' do
  it 'viewing LSOA check page for Lambeth postcode', cassette: 'SE17QA' do
    visit '/lsoa_checks/SE17QA'

    expect(page).to have_content 'SE17QA is in the LSOA 👍'
  end

  it 'viewing LSOA check page for Southwark postcode', cassette: 'SE17QD' do
    visit '/lsoa_checks/SE17QD'

    expect(page).to have_content 'SE17QD is in the LSOA 👍'
  end

  it 'viewing LSOA check page for neither Lambeth nor Southwark postcode', cassette: 'OX14AJ' do
    visit '/lsoa_checks/OX14AJ'

    expect(page).to have_content 'OX14AJ is not in the LSOA 👎'
  end

  it 'viewing LSOA check page for invalid postcode', cassette: 'invalid' do
    visit '/lsoa_checks/invalid'

    expect(page).to have_content 'invalid is not a valid postcode'
  end
end
