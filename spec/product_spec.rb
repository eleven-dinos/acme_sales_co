# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Product do
  let(:code)  { 'RO1' }
  let(:name)  { 'Red Widget' }
  let(:price) { 1.25 }

  subject { described_class.new(code: code, name: name, price: price) }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'validations' do
      context 'when code is missing' do
        let(:code) { nil }

        it 'raises CODE_MISSING' do
          expect { subject }.to raise_error(ProductError, ProductError::CODE_MISSING)
        end
      end

      context 'when name is missing' do
        let(:name) { nil }

        it 'raises NAME_MISSING' do
          expect { subject }.to raise_error(ProductError, ProductError::NAME_MISSING)
        end
      end

      context 'when price is negative' do
        let(:price) { -5 }

        it 'raises PRICE_INVALID' do
          expect { subject }.to raise_error(ProductError, ProductError::PRICE_INVALID)
        end
      end

      context 'when price is zero' do
        let(:price) { 0 }

        it 'raises PRICE_INVALID' do
          expect { subject }.to raise_error(ProductError, ProductError::PRICE_INVALID)
        end
      end

      context 'when price is not numeric' do
        let(:price) { 'not a number' }

        it 'raises PRICE_INVALID' do
          expect { subject }.to raise_error(ProductError, ProductError::PRICE_INVALID)
        end
      end
    end
  end
end
