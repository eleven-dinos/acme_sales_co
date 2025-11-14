# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basket do
  let(:product1) { double('Product', code: 'P001', name: 'Product 1', price: 10.0) }
  let(:product2) { double('Product', code: 'P002', name: 'Product 2', price: 20.0) }
  let(:catalogue) { double('Catalogue', find_by_code: product1) }
  
  let(:basket_item1) { double('BasketItem', product: product1, quantity: 2) }
  let(:basket_item2) { double('BasketItem', product: product2, quantity: 1) }

  let(:offer) { double('Offer', apply: 5.0) }
  let(:delivery_rule) { double('TieredDeliveryRule', calculate: 2.0) }

  subject { described_class.new(catalogue: catalogue, delivery_rules: delivery_rule, offers: [offer]) }

  describe '#add' do
    context 'when product exists in catalogue' do
      it 'adds a BasketItem to items' do
        allow(catalogue).to receive(:find_by_code).with('P001').and_return(product1)
        expect { subject.add('P001', quantity: 3) }.to change { subject.items.size }.by(1)
        expect(subject.items.last.product).to eq(product1)
        expect(subject.items.last.quantity).to eq(3)
      end
    end

    context 'when product does not exist' do
      it 'raises BasketError::INVALID_PRODUCT' do
        allow(catalogue).to receive(:find_by_code).with('INVALID').and_return(nil)
        expect { subject.add('INVALID') }.to raise_error(BasketError, BasketError::INVALID_PRODUCT)
      end
    end

    context 'when quantity is not given' do
      it 'defaults to 1' do
        allow(catalogue).to receive(:find_by_code).with('P001').and_return(product1)
        subject.add('P001')
        expect(subject.items.last.quantity).to eq(1)
      end
    end
  end

  describe '#calculate_sub_total' do
    it 'returns the sum of all item prices * quantities' do
      allow(subject).to receive(:items).and_return([
        BasketItem.new(product: product1, quantity: 2),
        BasketItem.new(product: product2, quantity: 1)
      ])
      expect(subject.calculate_sub_total).to eq(40.0)
    end
  end

  describe '#apply_offer' do
    context 'when offers are present' do
      it 'returns sum of all offer discounts' do
        expect(subject.apply_offer).to eq(5.0)
      end
    end

    context 'when no offers are present' do
      subject { described_class.new(catalogue: catalogue, delivery_rules: delivery_rule, offers: nil) }

      it 'returns 0.0' do
        expect(subject.apply_offer).to eq(0.0)
      end
    end
  end

  describe '#calculate_delivery_charges' do
    context 'when delivery_rules are present' do
      it 'returns calculated delivery charges' do
        expect(subject.calculate_delivery_charges(10.0)).to eq(2.0)
      end
    end

    context 'when delivery_rules are nil (pickup only)' do
      subject { described_class.new(catalogue: catalogue, delivery_rules: nil, offers: [offer]) }

      it 'returns 0.0' do
        expect(subject.calculate_delivery_charges(10.0)).to eq(0.0)
      end
    end
  end

  describe '#total' do
    context 'with subtotal, offers, and delivery charges' do
      it 'returns total = subtotal - discount + delivery' do
        items = [
          BasketItem.new(product: product1, quantity: 2),  # 2 * 10 = 20
          BasketItem.new(product: product2, quantity: 1)   # 1 * 20 = 20
        ]
        allow(subject).to receive(:items).and_return(items)
        total_expected = (40.0 - 5.0 + 2.0).round(2)
        expect(subject.total).to eq(total_expected)
      end
    end

    context 'with no offers and no delivery rules' do
      subject { described_class.new(catalogue: catalogue, delivery_rules: nil, offers: nil) }
      it 'returns just the subtotal' do
        items = [
          BasketItem.new(product: product1, quantity: 1),
          BasketItem.new(product: product2, quantity: 1)
        ]
        allow(subject).to receive(:items).and_return(items)
        expect(subject.total).to eq(30.0)
      end
    end
  end
end
