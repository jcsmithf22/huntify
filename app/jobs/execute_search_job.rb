class ExecuteSearchJob < ApplicationJob
  queue_as :default

  def perform(id)
    search = Search.includes(:user).find(id)
    user = search.user

    SearchMailer.with(search: search, user: user).was_found.deliver_later
  end
end
