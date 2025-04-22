class PeriodicSearchJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Load all Searches (without eager loading User)
    searches = Search.all

    # Queue a job for each search
    searches.each do |search|
      ExecuteSearchJob.perform_later(search.id)
    end
  end
end
