# frozen_string_literal: true

require 'pry'

require_relative 'lib/product'
require_relative 'lib/catalogue'
require_relative 'lib/basket_item'
require_relative 'lib/basket'
require_relative 'lib/tiered_delivery_rule'
require_relative 'lib/offers/offer'
require_relative 'lib/offers/buy_one_get_half_offer'
require_relative 'lib/errors/product_error'
require_relative 'lib/errors/basket_error'
red_widget   = Product.new(code: 'R01', name: 'Red Widget', price: 32.95)
green_widget = Product.new(code: 'G01', name: 'Green Widget', price: 24.95)
blue_widget  = Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
catalogue = Catalogue.new([red_widget, green_widget, blue_widget])
delivery_rule = TieredDeliveryRule.new
offers = [BuyOneGetHalfOffer.new('R01')]

def calculate_basket_total(codes, catalogue:, delivery_rules:, offers:)
  basket = Basket.new(catalogue: catalogue, delivery_rules: delivery_rules, offers: offers)
  codes.each { |code| basket.add(code) }
  basket.total
end

example_baskets = {
  %w[B01 G01] => 37.85,
  %w[R01 R01] => 54.37,
  %w[R01 G01] => 60.85,
  %w[B01 B01 R01 R01 R01] => 98.27
}

example_baskets.each do |codes, expected_total|
  total = calculate_basket_total(codes, catalogue: catalogue, delivery_rules: delivery_rule, offers: offers)
  puts "Basket: #{codes.join(', ')} | Total: $#{total} | Expected: $#{expected_total} | #{(total - expected_total).abs < 0.01 ? '✅' : '❌'}"
end
