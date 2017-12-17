module Mutations::AuthMutation
  def self.create(object_type)
    object_type.camelized_field :register_user, Types::AuthType do
      description 'Update a current user'
      argument :user, !UserCreateType
      resolve ->(_o, args, _ctx) {
        user = User.create(args[:user].to_h)
        if user.persisted?
          user.add_role :member
          auth = user.create_new_auth_token
          auth['user'] = user
          auth
        else
          user
        end
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

  argument :password_confirmation, !types.String do
    description 'Confirm password of the user.'
  end
end
