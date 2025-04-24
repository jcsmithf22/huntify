require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Huntify
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Enable cron enqueuing in this process
    config.good_job.enable_cron = true

    config.good_job.cron = {
      # Every 15 minutes, enqueue `ExampleJob.set(priority: -10).perform_later(42, "life", name: "Alice")`
      recurring_search_task: { # each recurring job must have a unique key
        cron: "*/1 * * * *", # cron-style scheduling format by fugit gem
        class: "PeriodicSearchJob", # name of the job class as a String; must reference an Active Job job class
        # args: [ 42, "life" ], # positional arguments to pass to the job; can also be a proc e.g. `-> { [Time.now] }`
        # kwargs: { name: "Alice" }, # keyword arguments to pass to the job; can also be a proc e.g. `-> { { name: NAMES.sample } }`
        # set: { priority: -10 }, # additional Active Job properties; can also be a lambda/proc e.g. `-> { { priority: [1,2].sample } }`
        description: "Recurring search queuing task" # optional description that appears in Dashboard
      }
    }
  end
end
