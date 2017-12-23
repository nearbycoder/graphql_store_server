class Devise::PasswordResetsController < DeviseTokenAuth::PasswordsController
  protected

  def render_edit_error
    redirect_to "#{ENV['CLIENT_ROOT_URL']}/not-found"
  end
end
