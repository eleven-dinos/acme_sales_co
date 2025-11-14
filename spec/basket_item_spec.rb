# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BasketItem do
  let(:product) { double('Product', code: 'P001', name: 'Product 1', price: 10.0) }

  subject { described_class.new(product: product, quantity: quantity) }

  context 'when quantity is provided' do
    let(:quantity) { 3 }

    it 'stores the product' do
      expect(subject.product).to eq(product)
    end

    it 'stores the quantity' do
      expect(subject.quantity).to eq(3)
    end
  end

  context 'when quantity is not provided' do
    let(:quantity) { nil }

    it 'defaults quantity to 1' do
      item = described_class.new(product: product)
      expect(item.quantity).to eq(1)
    end
  end
end
