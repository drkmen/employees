# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_MAIL']
  layout 'mailer'

  def send_wish(user, wish)
    @user, @wish = user, wish
    mail(to: ENV['CEO_EMAIL'], subject: 'Employees.loc - new wish')
  end
end
