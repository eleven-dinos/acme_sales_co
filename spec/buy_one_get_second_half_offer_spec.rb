# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BuyOneGetHalfOffer do
  let(:product) { double('Product', code: 'P001', name: 'Product 1', price: 10.0) }
  let(:other_product) { double('Product', code: 'P002', name: 'Product 2', price: 5.0) }
  let(:basket_item1) { double('BasketItem', product: product, quantity: quantity1) }
  let(:basket_item2) { double('BasketItem', product: product, quantity: quantity2) }
  let(:basket_item_other) { double('BasketItem', product: other_product, quantity: 1) }
  let(:basket) { double('Basket', items: [basket_item1, basket_item2, basket_item_other]) }

  subject { described_class.new('P001') }

  context 'when total quantity of product is even' do
    let(:quantity1) { 2 }
    let(:quantity2) { 2 }

    it 'applies discount to half of the items' do
      expect(subject.apply(basket)).to eq(10.0)
    end
  end

  context 'when total quantity of product is odd' do
    let(:quantity1) { 3 }
    let(:quantity2) { 1 }

    it 'applies discount to floor(total_quantity / 2) items' do
      expect(subject.apply(basket)).to eq(10.0)
    end
  end

  context 'when no matching product is in the basket' do
    let(:basket) { double('Basket', items: [basket_item_other]) }

    it 'returns 0 discount' do
      expect(subject.apply(basket)).to eq(0)
    end
  end
end
