Devise.setup do |config|
  config.mailer = 'UserMailer'

  # Allow unconfirmed users.
  config.allow_unconfirmed_access_for = 365.days
end
