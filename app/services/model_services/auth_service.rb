class ModelServices::AuthService < ModelServices::BaseModelService
  def create
    new_user = User.create(args[:user].to_h)
    if new_user.persisted?
      new_user.add_role :member
      auth = new_user.create_new_auth_token
      auth['user'] = new_user
      auth
    else
      new_user
    end
  end

  def forgot_password
    user = User.find_by(email: args[:user][:email])

    if user.present?
      user.send_reset_password_instructions
      RecursiveOpenStruct.new(success: true)
    else
      RecursiveOpenStruct.new(success: false, errors: ['No Email Found'])
    end
  end

  def reset_password
    ctx[:pundit].authorize current_user, :update?
    current_user.update(args[:user].to_h)
    current_user
  end

  def update
    ctx[:pundit].authorize current_user, :update?
    current_user.update(args[:user].to_h)
    current_user
  end

  def destroy
    ctx[:pundit].authorize current_user, :delete?
    current_user.destroy
    current_user
  end

  private

  def current_user
    ctx[:current_user]
  end
end
