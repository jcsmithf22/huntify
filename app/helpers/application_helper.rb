module ApplicationHelper
  def format_category(category_id)
    return "Any" if category_id.blank?

    category_key = EbayService::CATEGORIES.key(category_id.to_i)
    if category_key
      category_key.to_s.titleize.gsub("And", "&")
    else
      category_id
    end
  end
end
