# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits MSOA check page spec' do
  it 'viewing MSOA check page for Southwark postcode' do
    visit '/msoa_checks/SE17QD'

    expect(page).to have_content 'SE17QD is in the MSOA 👍'
  end

  it 'viewing MSOA check page for Southwark postcode' do
    visit '/msoa_checks/OX14AJ'

    expect(page).to have_content 'OX14AJ is not in the MSOA 👎'
  end
end
