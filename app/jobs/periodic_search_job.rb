class PeriodicSearchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Eager load all Searches with their associated User
    searches = Search.includes(:user).all

    # Example: iterate over each search and access its user
    searches.each do |search|
      Rails.logger.info "Search name: #{search.name}"
    end
  end
end
