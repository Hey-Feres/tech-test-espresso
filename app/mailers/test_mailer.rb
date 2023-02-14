class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.send_test.subject
  #
  def send_test
    @greeting = "Hi"

    mail to: params[:email]
  end
end
