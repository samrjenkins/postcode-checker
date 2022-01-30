# frozen_string_literal: true

require 'rails_helper'

describe 'Guests visits homepage' do
  it 'visiting homepage' do
    visit '/'

    expect(page).to have_current_path msoa_checks_path
  end

  it 'submitting postcode using form', cassette: 'SE17QA' do
    visit '/'

    fill_in 'Try a postcode...', with: 'SE17QA'
    click_on 'Go!'

    expect(page).to have_content 'SE17QA is in the MSOA 👍'
  end
end
