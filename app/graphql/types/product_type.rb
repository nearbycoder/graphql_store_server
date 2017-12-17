Types::ProductType = GraphQL::ObjectType.define do
  name 'Product'
  field :id, types.ID
  field :name, types.String
  field :description, types.String
  field :imageUrl, types.String do
    resolve ->(product, _args, _ctx) {
      product.image.url == '' ? nil : product.image.url
    }
  end
  field :imageName, types.String do
    resolve ->(product, _args, _ctx) {
      product.image_file_name
    }
  end
  camelized_field :created_at, Types::DateTimeType
  camelized_field :updated_at, Types::DateTimeType
  camelized_field :deleted_at, Types::DateTimeType

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.full_messages }
  end
end
