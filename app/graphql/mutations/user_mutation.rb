module Mutations::UserMutation
  def self.create(object_type)
    object_type.field :update_current_user, Types::UserType do
      authorize! :update, policy: CurrentUser
      description 'Update a current user'
      argument :user, !UserUpdateType
      resolve ->(_o, args, ctx) {
        current_user = ctx[:current_user]
        current_user.update(args[:user].to_h)
        current_user
      }
    end

    object_type.field :delete_current_user, Types::UserType do
      authorize! :update, policy: CurrentUser
      description 'Delete the current user'
      resolve ->(_o, _args, ctx) {
        current_user = ctx[:current_user]
        current_user.destroy
      }
    end
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
