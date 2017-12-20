module Mutations::ProductMutation
  def self.create(object_type)
    object_type.field :create_product, Types::ProductType do
      description 'Create a product'
      argument :product, ProductCreateType
      resolve ->(_product, args, ctx) {
        ModelServices::ProductService.new(args, ctx).create
      }
    end

    object_type.field :update_product, Types::ProductType do
      description 'Update a product'
      argument :id, !types.ID
      argument :product, ProductUpdateType
      resolve ->(_product, args, ctx) {
        ModelServices::ProductService.new(args, ctx).update
      }
    end

    object_type.field :delete_product, Types::ProductType do
      argument :id, !types.ID
      description 'Delete a product'
      resolve ->(_product, args, ctx) {
        ModelServices::ProductService.new(args, ctx).destroy
      }
    end
  end
end

ProductCreateType = GraphQL::InputObjectType.define do
  name 'ProductCreateType'
  description 'Properties for creating a Product'

  argument :name, !types.String do
    description 'Name of the product.'
  end

  argument :description, !types.String do
    description 'Description for the.'
  end

  argument :imageBase64, as: :image do
    type types.String
    description 'The base64 encoded version of the profile image to upload.'
  end

  argument :imageName, types.String, as: :image_file_name
end

ProductUpdateType = GraphQL::InputObjectType.define do
  name 'ProductUpdateType'
  description 'Properties for updating a Product'

  argument :name, types.String do
    description 'Name of the product.'
  end

  argument :description, types.String do
    description 'Description for the product.'
  end

  argument :imageBase64, as: :image do
    type types.String
    description 'The base64 encoded version of the profile image to upload.'
  end

  argument :imageName, types.String, as: :image_file_name
end
