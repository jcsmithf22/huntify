require "ebay/browse"
require "ebay/oauth/client_credentials_grant"

class EbayService
  attr_reader :search, :campaign_id

  def initialize(search, campaign_id: "123")
    @search = search
    @campaign_id = campaign_id
  end

  def self.search(search, campaign_id: "123")
    new(search, campaign_id: campaign_id).perform_ebay_search
  end

  def perform_ebay_search
    access_token = fetch_access_token
    request = Ebay.browse(
      campaign_id: @campaign_id,
      zip: search.postal_code,
      access_token: access_token,
      market_id: "EBAY_US" # Consider making this configurable
    )

    filter_string = build_filter_string
    response = request.search(q: search.keywords, filter: filter_string)
    results = JSON.parse(response.body)["itemSummaries"] || []

    # Filter results by title if include_description is false
    search.include_description ? results : filter_results_by_title(results)
  end

  private

    def fetch_access_token
      # Cache the token for 1 hour 55 minutes (eBay tokens typically last 2 hours)
      Rails.cache.fetch("ebay_access_token", expires_in: 6900.seconds) do
        Ebay::Oauth::ClientCredentialsGrant.new.mint_access_token
      end
    end

    def build_filter_string
      filters = []
      range_str = price_range_string
      filters << "price:[#{range_str}]" if range_str
      filters << "priceCurrency:USD"
      filters.join(",")
    end

    def price_range_string
      min = to_dollars(search.price_min_cents)
      max = to_dollars(search.price_max_cents)

      if min && max
        "#{min}..#{max}"
      elsif min
        "#{min}"
      elsif max
        "..#{max}"
      end
    end

    def to_dollars(cents)
      cents&.fdiv(100)
    end

    def filter_results_by_title(results)
      keywords_regex = Regexp.new(search.keywords.split.map { |word| Regexp.escape(word) }.join(".*"), "i")
      results.select { |item| item["title"] =~ keywords_regex }
    end
end
