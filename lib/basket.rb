# frozen_string_literal: true

# Basket class which will be represeting a cart/basket
# There can be either an offer present or not
# basket will always have the product_catalogue
# We have made an assumption here that delivery rules can either be present or not
# because a basket could also be pick up instead of delivered
class Basket
  attr_reader :items, :catalogue, :offers, :delivery_rules

  def initialize(catalogue:, delivery_rules:, offers:)
    @catalogue = catalogue
    @delivery_rules = delivery_rules
    @offers = offers
    @items = []
  end

  # Unless the quanitity is given we will be assuming it's a single quantity for that product
  def add(product_code, quantity: 1)
    product = @catalogue.find_by_code(product_code)
    raise BasketError, BasketError::INVALID_PRODUCT unless product

    items << BasketItem.new(product: product, quantity: quantity)
  end

  def total
    subtotal = calculate_sub_total
    discount = apply_offer.round(2)
    subtotal_after_discount = (subtotal - discount)
    delivery = calculate_delivery_charges(subtotal_after_discount)
    (subtotal_after_discount + delivery).round(2)
  end

  def calculate_sub_total
    items.sum { |item| item.product.price * item.quantity }
  end

  def apply_offer
    # retrun 0 incase there is not offer present
    offers ?  offers.sum { |offer| offer.apply(self) } : 0.0
  end

  def calculate_delivery_charges(subtotal_after_discount)
    # assuming the basket is pickup-only in that case no delivery rules will be applied
    delivery_rules ? delivery_rules.calculate(subtotal_after_discount) : 0.0
  end
end
