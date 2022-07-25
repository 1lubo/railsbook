# frozen_string_literal: true

class UserMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  default from: 'notifications@railsbook.com'

  def welcome_email
    puts '_USER MAILER!'
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Railsbook')
  end
end
