# frozen_string_literal: true

# product_error.rb (File defining the error class and constants)
class ProductError < StandardError
  CODE_MISSING = 'Product code must be present and not empty.'
  NAME_MISSING = 'Product name must be present and not empty.'
  PRICE_INVALID = 'Product price must be a positive number.'
end
