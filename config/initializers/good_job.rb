GoodJob.configure_active_record do
  connects_to database: { writing: :queue }
end

ActiveSupport.on_load(:good_job_application_controller) do
  include Authentication

  allow_unauthenticated_access

  before_action do
    raise ActionController::RoutingError.new("Not Found") unless authenticated?
  end
end
