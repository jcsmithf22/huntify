require "ebay/browse"
require "ebay/oauth/client_credentials_grant"

class ExecuteSearchJob < ApplicationJob
  queue_as :default

  def perform(id)
    search = Search.includes(:user).find(id)
    user = search.user

    access_token = Ebay::Oauth::ClientCredentialsGrant.new.mint_access_token
    request = Ebay.browse(campaign_id: "123", zip: search.postal_code, access_token: access_token, market_id: "EBAY_US")

    min = to_dollars(search.price_min_cents)
    max = to_dollars(search.price_max_cents)

    range_str =
      if min && max
        "#{min}..#{max}"
      elsif min
        "#{min}"
      elsif max
        "..#{max}"
      end

    filters = []
    filters << "price:[#{range_str}]" if range_str
    filters << "priceCurrency:USD"

    filter_string = filters.join(",")

    response = request.search(q: search.keywords, filter: filter_string)

    search_results = JSON.parse(response.body)["itemSummaries"] || []

    puts "Found #{search_results.size} results for search #{search.name}"

    if search_results.any?
      SearchMailer.with(search: search, user: user, results: search_results).was_found.deliver_later
    end
  end

  private
    def to_dollars(cents)
      cents&.fdiv(100)
    end
end
