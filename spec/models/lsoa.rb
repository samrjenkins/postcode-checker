# frozen_string_literal: true

require 'rails_helper'

describe Lsoa do
  describe '#save' do
    subject { described_class.new(name: name).save }

    context 'when name is not present' do
      let(:name) { nil }

      it 'does not save the record' do
        expect { subject }.not_to change(Lsoa, :count)
      end
    end

    context 'when name is empty string' do
      let(:name) { '' }

      it 'does not save the record' do
        expect { subject }.not_to change(Lsoa, :count)
      end
    end

    context 'when name is blank string' do
      let(:name) { ' ' }

      it 'does not save the record' do
        expect { subject }.not_to change(Lsoa, :count)
      end
    end

    context 'when name is already taken by another record' do
      let(:name) { 'dummy_name' }

      before { Lsoa.create!(name: name) }

      it 'does not save the record' do
        expect { subject }.not_to change(Lsoa, :count)
      end
    end

    context 'when name is present and unique' do
      let(:name) { 'dummy_name' }

      it 'saves the record' do
        expect { subject }.to change(Lsoa, :count).by(1)
      end
    end
  end
end
