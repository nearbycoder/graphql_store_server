Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, types.ID
  field :name, types.String
  field :email, types.String
  camelized_field :created_at, Types::DateTimeType
  camelized_field :updated_at, Types::DateTimeType
  camelized_field :deleted_at, Types::DateTimeType

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.full_messages }
  end
end
