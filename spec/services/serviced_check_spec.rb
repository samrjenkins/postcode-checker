# frozen_string_literal: true

require 'rails_helper'

describe ServicedCheck do
  describe '.call' do
    subject { described_class.call(postcode) }

    context 'when postcode is explicitly allowed' do
      let(:postcode) { 'SH24 1AB' }

      it { is_expected.to be true }

      it 'does not call LsoaCheck' do
        expect(LsoaCheck).not_to receive(:call)
        subject
      end
    end

    context 'when postcode is not expicitly allowed' do
      let(:postcode) { 'dummy_postcode' }

      before { expect(LsoaCheck).to receive(:call).and_return('dummy_lsoa_check') }

      it { is_expected.to eq 'dummy_lsoa_check' }
    end
  end
end
