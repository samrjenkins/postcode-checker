# frozen_string_literal: true

require 'rails_helper'

describe MsoaCheck do
  describe '.call' do
    subject { described_class.call(postcode) }

    let(:postcode) { 'dummy_postcode' }

    context 'when fetching postcode data is successful' do
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

    context 'when fetching postcode data raises PostcodeNotFoundError' do
      before do
        expect(FetchPostcodeData)
          .to receive(:call)
          .with(postcode)
          .and_raise(PostcodeNotFoundError)
      end

      it { is_expected.to be true }
    end

    context 'when fetching postcode data raises InvalidPostcodeError' do
      before do
        expect(FetchPostcodeData)
          .to receive(:call)
          .with(postcode)
          .and_raise(InvalidPostcodeError)
      end

      it 'does not rescue the error' do
        expect { subject }.to raise_error InvalidPostcodeError
      end
    end
  end
end
