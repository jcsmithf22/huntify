class Search < ApplicationRecord
  belongs_to :user
  
  monetize :price_min_cents, allow_nil: true
  monetize :price_max_cents, allow_nil: true
  monetize :best_offer_max_cents, allow_nil: true

  validates :name, presence: true, length: { maximum: 255 }
  validates :keywords, presence: true, length: { maximum: 600 }
  validates :postal_code, presence: true

  def formatted_listing_type
    listing_type.gsub("_", " ").capitalize if listing_type.present?
  end

  def formatted_condition
    condition.gsub("_", " ").capitalize if condition.present?
  end
end
