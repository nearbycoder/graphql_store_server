Types::CartType = GraphQL::ObjectType.define do
  name 'Cart'
  field :id, types.ID
  field :name, types.String
  field :total_price, types.Int
  field :active, types.Boolean
  field :user, Types::UserType do
    preload :user
  end
  field :cart_items, types[Types::CartItemType] do
    preload :cart_items
  end
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.full_messages }
  end
end
