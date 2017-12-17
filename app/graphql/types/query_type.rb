Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  Queries::AuthQuery.create(self)
  Queries::UserQuery.create(self)
  Queries::ProductQuery.create(self)
end
