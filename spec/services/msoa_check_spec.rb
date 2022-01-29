# frozen_string_literal: true

require 'rails_helper'

describe MsoaCheck do
  describe '.call' do
    subject { described_class.call(postcode) }

    context 'when postcode is not a Southwark postcode' do
      let(:postcode) { 'OX1 4AJ' }

      it { is_expected.to be false }
    end

    context 'when postcode is an uppercase Southwark postcode' do
      let(:postcode) { 'SE17QD' }

      it { is_expected.to be true }
    end

    context 'when postcode is a lowercase Southwark postcode' do
      let(:postcode) { 'se17qd' }

      it { is_expected.to be true }
    end

    context 'when postcode is a mixed-case Southwark postcode' do
      let(:postcode) { 'sE17Qd' }

      it { is_expected.to be true }
    end
  end
end
