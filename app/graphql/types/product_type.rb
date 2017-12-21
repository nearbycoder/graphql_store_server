Types::ProductType = GraphQL::ObjectType.define do
  name 'Product'
  field :id, types.ID
  field :name, types.String
  field :description, types.String
  field :image_url, types.String do
    resolve ->(product, _args, _ctx) {
      product.image.url == '' ? nil : product.image.url
    }
  end
  field :image_name, types.String do
    resolve ->(product, _args, _ctx) {
      product.image_file_name
    }
  end
  field :variants, types[Types::VariantType], function: Resolvers::VariantResolver do
    preload :variants
  end
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :deleted_at, Types::DateTimeType

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.full_messages }
  end
end
