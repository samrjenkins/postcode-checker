# frozen_string_literal: true

require 'rails_helper'

describe FetchPostcodeData do
  describe '.call' do
    subject { described_class.call(postcode) }

    context 'when a recognised postcode', cassette: 'SE17QA' do
      let(:postcode) { 'SE17QA' }

      it { is_expected.to include('lsoa' => 'Lambeth 036B') }
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
