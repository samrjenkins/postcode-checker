# frozen_string_literal: true

require 'rails_helper'

describe 'POST /lsoa_checks' do
  subject { post lsoa_checks_path, params: { postcode: 'dummy_postcode' } }

  it { is_expected.to redirect_to lsoa_check_path('dummy_postcode') }
end
