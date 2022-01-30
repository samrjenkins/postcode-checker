# frozen_string_literal: true

require 'rails_helper'

describe MsoaCheck do
  describe '.call' do
    subject { described_class.call(postcode) }

    let(:postcode) { 'dummy_postcode' }

    before do
      expect(FetchPostcodeData)
        .to receive(:call)
        .with(postcode)
        .and_return(response_postcode_data)
    end

    context 'when MSOA is for Southwark' do
      let(:response_postcode_data) { { 'msoa' => 'Southwark MSOA' } }

      it { is_expected.to be true }
    end

    context 'when MSOA is for Lambeth' do
      let(:response_postcode_data) { { 'msoa' => 'Lambeth MSOA' } }

      it { is_expected.to be true }
    end

    context 'when MSOA is for neither Lambeth nor Southwark' do
      let(:response_postcode_data) { { 'msoa' => 'Another MSOA' } }

      it { is_expected.to be false }
    end
  end
end
