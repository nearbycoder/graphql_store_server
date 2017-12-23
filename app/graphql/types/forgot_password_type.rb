Types::ForgotPasswordType = GraphQL::ObjectType.define do
  name 'ForgotPasswordType'
  description 'A Auth Token'
  field :success, !types.Boolean do
    resolve ->(obj, _args, _ctx) { obj.success }
  end

  field :errors, types[types.String] do
    resolve ->(obj, _args, _ctx) { obj.errors }
  end
end
