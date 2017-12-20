GraphqlStoreSchema = GraphQL::Schema.define do
  query(Types::QueryType)
  mutation(Mutations::MutationRoot)

  instrument(:field, GraphQL::Pundit::Instrumenter.new)
  instrument(:field, FieldNameCamelizer.new)
  instrument(:argument, FieldNameCamelizer.new)

  use GraphQL::Batch
  enable_preloading
end

GraphQL::Errors.configure(GraphqlStoreSchema) do
  rescue_from ActiveRecord::RecordNotFound do |exception|
    GraphQL::ExecutionError.new(exception.message)
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    GraphQL::ExecutionError.new(exception.record.errors.full_messages.join("\n"))
  end

  rescue_from Pundit::NotAuthorizedError do |_exception|
    GraphQL::ExecutionError.new('Not Authorized')
  end

  # rescue_from StandardError do |exception|
  #   GraphQL::ExecutionError.new("Please try to execute the query for this field later")
  # end
end
