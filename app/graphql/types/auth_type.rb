Types::AuthType = GraphQL::ObjectType.define do
  name 'Auth'
  description 'A Auth Token'
  camelized_field :access_token, types.String do
    resolve ->(obj, _args, _ctx) {
      obj['access-token']
    }
  end
  camelized_field :token_type, types.String do
    resolve ->(obj, _args, _ctx) {
      obj['token-type']
    }
  end
  field :client, types.String do
    resolve ->(obj, _args, _ctx) {
      obj['client']
    }
  end
  field :expiry, types.String do
    resolve ->(obj, _args, _ctx) {
      obj['expiry']
    }
  end
  field :uid, types.String do
    resolve ->(obj, _args, _ctx) {
      obj['uid']
    }
  end
  field :user, Types::UserType do
    resolve ->(obj, _args, _ctx) {
      obj['user']
    }
  end

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.is_a?(Hash) ? nil : obj.errors.full_messages.uniq }
  end
end
