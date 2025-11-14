# frozen_string_literal: true

# lib/offers/offer.rb
class Offer
  # Apply discount to the basket.
  def apply(basket)
    raise NotImplementedError, 'Subclasses must implement #apply'
  end
end
