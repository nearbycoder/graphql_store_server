Mutations::MutationRoot = GraphQL::ObjectType.define do
  name 'Mutation'

  Mutations::AuthMutation.create(self)
  Mutations::UserMutation.create(self)
  Mutations::ProductMutation.create(self)
end
