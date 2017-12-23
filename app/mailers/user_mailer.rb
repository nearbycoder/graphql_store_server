class UserMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers

  def reset_password_instructions(record, token, _opts = {})
    @resource = record
    @reset_url = edit_password_url(record, reset_password_token: token, config: 'default', redirect_url: "#{ENV['CLIENT_ROOT_URL']}/reset-password")
    mail(from: 'admin@graphqlstore.com', to: record.email, subject: 'Password Reset')
  end
end
