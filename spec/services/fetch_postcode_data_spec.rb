# frozen_string_literal: true

require 'rails_helper'

describe FetchPostcodeData do
  describe '.call' do
    subject { described_class.call(postcode) }

    context 'when a Southwark postcode' do
      let(:postcode) { 'SE17QD' }

      it { is_expected.to eq({ msoa: "Southwark 034" }) }
    end

    context 'when not a Southwark postcode' do
      let(:postcode) { 'OX1 4AJ' }

      it { is_expected.to eq({ msoa: "Another MSOA" }) }
    end
  end
end
