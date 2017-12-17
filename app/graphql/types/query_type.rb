Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  Queries::AuthQuery.create(self)
  Queries::UserQuery.create(self)
  Queries::ProductQuery.create(self)
  Queries::VariantQuery.create(self)
  Queries::CartQuery.create(self)
  Queries::CartItemQuery.create(self)
end
