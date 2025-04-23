class ApplicationMailer < ActionMailer::Base
  default from: "alert@huntify.app"
  layout "mailer"
end
