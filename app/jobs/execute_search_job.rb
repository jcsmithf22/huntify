class ExecuteSearchJob < ApplicationJob
  queue_as :default

  def perform(id)
    search = Search.includes(:user).find(id)
    user = search.user

    search_results = EbayService.search(search)

    if search_results.any?
      SearchMailer.with(search: search, user: user, results: search_results).was_found.deliver_later
    end
  end
end
