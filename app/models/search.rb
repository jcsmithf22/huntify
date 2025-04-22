class Search < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :keywords, presence: true, length: { maximum: 600 }
  validates :postal_code, presence: true

  before_validation :convert_prices_to_cents

  private

  def convert_prices_to_cents
    self.price_min_cents = dollars_to_cents(price_min_cents) if price_min_cents.present?
    self.price_max_cents = dollars_to_cents(price_max_cents) if price_max_cents.present?
    self.best_offer_max_cents = dollars_to_cents(best_offer_max_cents) if best_offer_max_cents.present?
  end

  def dollars_to_cents(amount)
    return nil if amount.nil?
    
    # Convert string amounts like "10.50" to cents (1050)
    if amount.is_a?(String)
      (BigDecimal(amount) * 100).to_i
    # Convert float amounts like 10.50 to cents (1050)
    elsif amount.is_a?(Float)
      (amount * 100).to_i
    # If it's already an integer, assume it's already in cents
    elsif amount.is_a?(Integer)
      amount
    end
  end
end
