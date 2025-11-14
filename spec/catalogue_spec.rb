# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Catalogue do
  let(:product1) { double('Product', code: 'P001', name: 'Product 1', price: 10.0) }
  let(:product2) { double('Product', code: 'P002', name: 'Product 2', price: 20.0) }
  let(:products) { [product1, product2] }

  subject { described_class.new(products) }

  describe '#initialize' do
    it 'stores products as a hash keyed by product code' do
      expect(subject.products).to eq({
        'P001' => product1,
        'P002' => product2
      })
    end

    context 'when initialized with no products' do
      subject { described_class.new }

      it 'creates an empty hash' do
        expect(subject.products).to eq({})
      end
    end
  end

  describe '#find_by_code' do
    context 'when the product exists' do
      it 'returns the product object' do
        expect(subject.find_by_code('P001')).to eq(product1)
      end
    end

    context 'when the product does not exist' do
      it 'returns nil' do
        expect(subject.find_by_code('NON_EXISTENT')).to be_nil
      end
    end
  end
end
