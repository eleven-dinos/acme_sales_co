# frozen_string_literal: true

# basket_error.rb (File defining the error class and constants)
class BasketError < StandardError
  INVALID_PRODUCT = 'Product is not present in catalogue.'
end
