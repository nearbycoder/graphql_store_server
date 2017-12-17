module Mutations::ProductMutation
  def self.create(object_type)
    object_type.camelized_field :create_product, Types::ProductType do
      authorize! :create, policy: Product
      description 'Create a product'
      argument :product, ProductCreateType
      resolve ->(_product, args, _ctx) {
        Product.create(args[:product].to_h)
      }
    end

    object_type.camelized_field :update_product, Types::ProductType do
      authorize! :update, policy: Product
      description 'Update a product'
      argument :product, ProductUpdateType
      resolve ->(_product, args, _ctx) {
        product = Product.find(args[:id])
        product.update(args[:product].to_h)
        product
      }
    end

    object_type.camelized_field :delete_product, Types::ProductType do
      authorize! :delete, policy: Product
      argument :id, !types.ID
      description 'Delete a product'
      resolve ->(_product, _args, _ctx) {
        product = Product.find(args[:id])
        product.destroy
        product
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

  argument :imageName, types.String, as: :image_file_name, default_value: 'image.jpg'
end

ProductUpdateType = GraphQL::InputObjectType.define do
  name 'ProductUpdateType'
  description 'Properties for updating a Product'

  argument :name, types.String do
    description 'Name of the product.'
  end

  argument :description, types.String do
    description 'Description for the.'
  end

  argument :imageBase64, as: :image do
    type types.String
    description 'The base64 encoded version of the profile image to upload.'
  end

  argument :imageName, types.String, as: :image_file_name, default_value: 'image.jpg'
end
