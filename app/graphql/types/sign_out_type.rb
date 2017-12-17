Types::SignOutType = GraphQL::ObjectType.define do
  name 'SignOut'
  description 'A Auth Token'
  field :success, !types.Boolean do
    resolve ->(obj, _args, _ctx) { obj }
  end
end
