# frozen_string_literal: true

# This catalogue class will be passed to basket with all the products in it.
# It is going to expose method for finding the product in the catalogue by code.
class Catalogue
  attr_reader :products

  def initialize(products = [])
    @products = products.map { |p| [p.code, p] }.to_h
  end

  def find_by_code(product_code)
    products[product_code]
  end
end
