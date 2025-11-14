# frozen_string_literal: true

require_relative 'errors/product_error'

# Represents a single catalogue item with fixed attributes (code, name, price).
class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    raise ProductError, ProductError::CODE_MISSING if code.nil?
    raise ProductError, ProductError::NAME_MISSING if name.nil?
    raise ProductError, ProductError::PRICE_INVALID unless price.is_a?(Numeric) && price.positive?

    @code = code
    @name = name
    @price = price
  end
end
