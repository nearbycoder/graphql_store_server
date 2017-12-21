module Queries::AuthQuery
  def self.create(object_type)
    object_type.field :sign_in_user do
      type Types::AuthType
      argument :email, !types.String
      argument :password, !types.String
      description 'Sign in User'
      resolve ->(_obj, args, _ctx) do
        user = User.find_by(email: args[:email])
        if user && user.valid_password?(args[:password])
          auth = user.create_new_auth_token
          auth['user'] = user
          auth
        else
          raise Pundit::NotAuthorizedError
        end
      end
    end

    object_type.field :sign_out_user do
      type Types::SignOutType
      argument :token, !types.String
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

    object_type.field :valid_token do
      type Types::UserType
      description 'Validate User'
      resolve ->(_obj, _args, ctx) do
        user = ctx[:current_user]

        user if user
      end
    end
  end
end
