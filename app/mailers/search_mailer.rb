class SearchMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.search_mailer.was_found.subject
  #
  def was_found
    @search = params[:search]
    mail to: params[:user].email_address
  end
end
