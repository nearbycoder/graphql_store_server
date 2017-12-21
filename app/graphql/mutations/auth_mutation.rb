module Mutations::AuthMutation
  def self.create(object_type)
    object_type.field :register_user, Types::AuthType do
      description 'Update a current user'
      argument :user, UserCreateType
      resolve ->(_root, args, ctx) {
        ModelServices::AuthService.new(args, ctx).create
      }
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
