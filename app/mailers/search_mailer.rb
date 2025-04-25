class SearchMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.search_mailer.was_found.subject
  #
  def was_found
    @search = params[:search]
    @results = params[:results]
    @total = params[:total]
    mail to: params[:user].email_address, subject: "#{@results.length} results found for #{@search.name}"
  end
end
