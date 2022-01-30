# frozen_string_literal: true

require 'rails_helper'

describe 'POST /msoa_checks' do
  subject { post msoa_checks_path, params: { postcode: 'dummy_postcode' } }

  it { is_expected.to redirect_to msoa_check_path('dummy_postcode') }
end
