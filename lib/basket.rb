# frozen_string_literal: true

# Basket class which will be represeting a cart/basket
# There can be either an offer present or not
# basket will always have the product_catalogue
# We have made an assumption here that delivery rules can either be present or not
# because a basket could also be pick up instead of delivered
class Basket

  attr_reader :catalogue, :delivery_rules, :offer

  def initialize(catalogue:, delivery_rules:, offer:)
    @catalogue = catalogue
    @delivery_rules = delivery_rules
    @offer = offer
  end
end