# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TieredDeliveryRule do
  subject(:delivery_rule) { described_class.new }

  describe '#calculate' do
    context 'when subtotal is less than 50' do
      let(:subtotal) { 25.0 }

      it 'returns 4.95 as delivery cost' do
        expect(delivery_rule.calculate(subtotal)).to eq(4.95)
      end
    end

    context 'when subtotal is between 50 and 89.99' do
      let(:subtotal) { 75.0 }

      it 'returns 2.95 as delivery cost' do
        expect(delivery_rule.calculate(subtotal)).to eq(2.95)
      end
    end

    context 'when subtotal is 90 or more' do
      let(:subtotal) { 120.0 }

      it 'returns 0.0 as delivery cost' do
        expect(delivery_rule.calculate(subtotal)).to eq(0.0)
      end
    end

    context 'edge cases at boundaries' do
      it 'returns 4.95 for subtotal exactly 0' do
        expect(delivery_rule.calculate(0)).to eq(4.95)
      end

      it 'returns 2.95 for subtotal exactly 50' do
        expect(delivery_rule.calculate(50)).to eq(2.95)
      end

      it 'returns 0.0 for subtotal exactly 90' do
        expect(delivery_rule.calculate(90)).to eq(0.0)
      end
    end
  end
end
