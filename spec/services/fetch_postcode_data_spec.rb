# frozen_string_literal: true

require 'rails_helper'

describe FetchPostcodeData do
  describe '.call' do
    subject { described_class.call(postcode) }

    context 'when a Lambeth postcode', cassette: 'SE17QA' do
      let(:postcode) { 'SE17QA' }

      it { is_expected.to include('msoa' => 'Lambeth 036') }
    end

    context 'when a Southwark postcode', cassette: 'SE17QD' do
      let(:postcode) { 'SE17QD' }

      it { is_expected.to include('msoa' => 'Southwark 034') }
    end

    context 'when not a Southwark postcode', cassette: 'OX14AJ' do
      let(:postcode) { 'OX14AJ' }

      it { is_expected.not_to include('msoa' => 'Southwark 034') }
    end
  end
end
