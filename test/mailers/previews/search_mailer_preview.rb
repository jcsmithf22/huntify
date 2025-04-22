# Preview all emails at http://localhost:3000/rails/mailers/search_mailer
class SearchMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/search_mailer/was_found
  def was_found
    SearchMailer.was_found
  end
end
