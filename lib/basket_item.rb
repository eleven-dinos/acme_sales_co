# frozen_string_literal: true

# This class is going to represent a item in a basket.
# A basket_item should always have a product so it will be created from the basket
# and basket is responsible to make sure that the product is always present before creating a basket_item
class BasketItem
  attr_reader :product, :quantity

  def initialize(product:, quantity: 1)
    @product = product
    @quantity = quantity
  end
end
