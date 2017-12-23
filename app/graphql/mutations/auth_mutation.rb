module Mutations::AuthMutation
  def self.create(object_type)
    object_type.field :register_user, Types::AuthType do
      description 'Update a current user'
      argument :user, !UserCreateType
      resolve ->(_root, args, ctx) {
        ModelServices::AuthService.new(args, ctx).create
      }
    end

    object_type.field :forgot_password, Types::ForgotPasswordType do
      description 'Send Password Reset Email'
      argument :user, !UserForgotPasswordType
      resolve ->(_root, args, ctx) {
        ModelServices::AuthService.new(args, ctx).forgot_password
      }
    end

    object_type.field :reset_password, Types::AuthType do
      description 'Reset Password and Signin'
      argument :user, !UserResetPasswordType
      resolve ->(_root, args, ctx) {
        ModelServices::AuthService.new(args, ctx).reset_password
      }
    end

    object_type.field :sign_in_user do
      type Types::AuthType
      argument :user, !UserSignInType
      description 'Sign in User'
      resolve ->(_obj, args, _ctx) do
        user = User.find_by(email: args[:user][:email])
        if user && user.valid_password?(args[:user][:password])
          auth = user.create_new_auth_token
          auth['user'] = user
          auth
        else
          RecursiveOpenStruct.new(errors: { full_messages: ['Invalid Credentials'] })
        end
      end
    end

    object_type.field :sign_out_user do
      type Types::SignOutType
      argument :client, !types.String
      argument :uid, !types.String
      description 'Sign out User'
      resolve ->(_obj, args, _ctx) do
        user = User.find_by(email: args[:uid])
        if user && args[:client] && user.tokens[args[:client]]
          user.tokens.delete(args[:client])
          user.save!
          true
        else
          false
        end
      end
    end

    object_type.field :update_current_user, Types::UserType do
      description 'Update a current user'
      argument :user, !UserUpdateType
      resolve ->(_root, args, ctx) {
        ModelServices::AuthService.new(args, ctx).update
      }
    end

    object_type.field :delete_current_user, Types::UserType do
      description 'Delete the current user'
      resolve ->(_root, args, ctx) {
        ModelServices::AuthService.new(args, ctx).destroy
      }
    end
  end
end

UserForgotPasswordType = GraphQL::InputObjectType.define do
  name 'UserForgotPasswordType'
  description 'Properties for signing in a user'

  argument :email, !types.String do
    description 'Email of the user.'
  end
end

UserSignInType = GraphQL::InputObjectType.define do
  name 'UserSignInType'
  description 'Properties for signing in a user'

  argument :email, !types.String do
    description 'Email of the user.'
  end

  argument :password, !types.String do
    description 'Password of the user.'
  end
end

UserResetPasswordType = GraphQL::InputObjectType.define do
  name 'UserResetPasswordType'
  description 'Properties for resetting a users password'

  argument :password, !types.String do
    description 'Password of the user.'
  end

  argument :passwordConfirmation, !types.String, as: :password_confirmation do
    description 'Confirm password of the user.'
  end
end

UserCreateType = GraphQL::InputObjectType.define do
  name 'UserInputType'
  description 'Properties for creating and updating a User'

  argument :name, !types.String do
    description 'Name of the user.'
  end

  argument :email, !types.String do
    description 'Email of the user.'
  end

  argument :password, !types.String do
    description 'Password of the user.'
  end

  argument :passwordConfirmation, !types.String, as: :password_confirmation do
    description 'Confirm password of the user.'
  end
end

UserUpdateType = GraphQL::InputObjectType.define do
  name 'UserUpdateType'
  description 'Properties for creating and updating a User'

  argument :name, types.String do
    description 'Name of the user.'
  end

  argument :email, types.String do
    description 'Email of the user.'
  end

  argument :password, types.String do
    description 'Password of the user.'
  end
end
