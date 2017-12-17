Types::CartItemType = GraphQL::ObjectType.define do
  name 'CartItem'
  field :id, types.ID
  field :quantity, types.String
  field :price, types.Int
  field :variant, Types::VariantType do
    preload :variant
  end
  field :cart, Types::CartType do
    preload :cart
  end
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.full_messages }
  end
end
