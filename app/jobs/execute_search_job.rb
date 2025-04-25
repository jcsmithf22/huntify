class ExecuteSearchJob < ApplicationJob
  queue_as :default

  def perform(id)
    search = Search.includes(:user).find(id)
    user = search.user

    search_results = EbayService.search(search)

    listings = search_results[:results]
    total = search_results[:total]

    if listings.any?
      SearchMailer.with(search: search, user: user, results: listings, total: total).was_found.deliver_later
    end
  end
end
