# frozen_string_literal: true
require_relative 'offer'

# lib/offers/buy_one_get_half_offer.rb
class BuyOneGetHalfOffer < Offer

  def initialize(product_code)
    super()
    @product_code = product_code
  end

  def apply(basket)
    # Select all basket items with the product code
    items = basket.items.select { |item| item.product.code == @product_code }
    total_quantity = items.sum(&:quantity)

    pairs = total_quantity / 2
    return 0 if pairs.zero?

    # Each discounted item is half price
    price = items.first.product.price
    pairs * (price / 2)
  end
end
