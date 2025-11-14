# frozen_string_literal: true
# lib/delivery_rule.rb

# Calculates delivery cost based on subtotal
class TieredDeliveryRule
  def calculate(subtotal)
    case subtotal
    when 0...50
      4.95
    when 50...90
      2.95
    else
      0.0
    end
  end
end
