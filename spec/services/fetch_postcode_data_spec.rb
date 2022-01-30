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

    context 'when an unrecognised postcode', cassette: 'SH241AA' do
      let(:postcode) { 'SH241AA' }

      it 'raises an error' do
        expect { subject }.to raise_error PostcodeNotFoundError
      end
    end

    context 'when an invalid postcode', cassette: 'invalid' do
      let(:postcode) { 'invalid' }

      it 'raises an error' do
        expect { subject }.to raise_error InvalidPostcodeError
      end
    end

    context 'when an unprocessable postcode', cassette: '???' do
      let(:postcode) { '???' }

      it 'raises an error' do
        expect { subject }.to raise_error InvalidPostcodeError
      end
    end
  end
end
