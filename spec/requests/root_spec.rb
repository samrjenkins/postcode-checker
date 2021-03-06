# frozen_string_literal: true

require 'rails_helper'

describe 'GET /' do
  subject { get root_path }

  it { is_expected.to redirect_to lsoa_checks_path }
end
