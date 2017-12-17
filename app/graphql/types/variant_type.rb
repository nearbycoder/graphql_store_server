Types::VariantType = GraphQL::ObjectType.define do
  name 'Variant'
  field :id, types.ID
  field :name, types.String
  field :price, types.Int
  field :description, types.String
  field :imageUrl, types.String do
    resolve ->(variant, _args, _ctx) {
      variant.image.url == '' ? nil : variant.image.url
    }
  end
  field :imageName, types.String do
    resolve ->(variant, _args, _ctx) {
      variant.image_file_name
    }
  end
  field :product, Types::ProductType do
    preload :product
  end
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.full_messages }
  end
end
