require "test_helper"

class SearchMailerTest < ActionMailer::TestCase
  test "was_found" do
    mail = SearchMailer.was_found
    assert_equal "Was found", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
