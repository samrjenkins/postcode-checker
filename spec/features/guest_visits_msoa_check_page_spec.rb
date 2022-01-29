# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits MSOA check page spec' do
  it 'viewing MSOA check page' do
    visit '/msoa_checks/SE17QD'

    expect(page).to have_content 'SE17QD is in the MSOA!'
  end
end
