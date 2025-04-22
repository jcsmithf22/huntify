class Search < ApplicationRecord
  monetize :price_min_cents, allow_nil: true
  monetize :price_max_cents, allow_nil: true
  monetize :best_offer_max_cents, allow_nil: true

  validates :name, presence: true, length: { maximum: 255 }
  validates :keywords, presence: true, length: { maximum: 600 }
  validates :postal_code, presence: true
end
