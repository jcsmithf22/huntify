GoodJob.configure_active_record do
  connects_to database: { writing: :queue }
end

ActiveSupport.on_load(:good_job_application_controller) do
  include Authentication
end
