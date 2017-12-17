GraphQL::ObjectType.accepts_definitions(camelized_field: CamelizedField)
GraphQL::InterfaceType.accepts_definitions(camelized_field: CamelizedField)

GraphqlStoreSchema = GraphQL::Schema.define do
  query(Types::QueryType)
  mutation(Mutations::MutationRoot)

  instrument(:field, GraphQL::Pundit::Instrumenter.new)
  instrument(:camelized_field, GraphQL::Pundit::Instrumenter.new)

  use GraphQL::Batch
  enable_preloading
end
