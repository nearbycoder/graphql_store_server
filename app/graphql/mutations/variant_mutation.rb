module Mutations::VariantMutation
  def self.create(object_type)
    object_type.field :create_Variant, Types::VariantType do
      authorize! :create, policy: Variant
      description 'Create a Variant'
      argument :variant, VariantCreateType
      resolve ->(_variant, args, _ctx) {
        Variant.create(args[:variant].to_h)
      }
    end

    object_type.field :update_Variant, Types::VariantType do
      authorize! :update, policy: Variant
      argument :id, !types.ID
      description 'Update a Variant'
      argument :variant, VariantUpdateType
      resolve ->(_variant, args, _ctx) {
        variant = Variant.find(args[:id])
        variant.update(args[:variant].to_h)
        variant
      }
    end

    object_type.field :delete_Variant, Types::VariantType do
      authorize! :delete, policy: Variant
      argument :id, !types.ID
      description 'Delete a Variant'
      resolve ->(_variant, _args, _ctx) {
        variant = Variant.find(args[:id])
        variant.destroy
        variant
      }
    end
  end
end

VariantCreateType = GraphQL::InputObjectType.define do
  name 'VariantCreateType'
  description 'Properties for creating a Variant'

  argument :productId, !types.ID, as: :product_id do
    description 'Id of the product to associate with.'
  end

  argument :name, !types.String do
    description 'Name of the variant.'
  end

  argument :description, !types.String do
    description 'Description for the variant.'
  end

  argument :price, !types.Int do
    description 'Price for the variant.'
  end

  argument :imageBase64, as: :image do
    type types.String
    description 'The base64 encoded version of the profile image to upload.'
  end

  argument :imageName, types.String, as: :image_file_name
end

VariantUpdateType = GraphQL::InputObjectType.define do
  name 'VariantUpdateType'
  description 'Properties for updating a Variant'

  argument :name, types.String do
    description 'Name of the variant.'
  end

  argument :description, types.String do
    description 'Description for the.'
  end

  argument :price, types.Int do
    description 'Price for the variant.'
  end

  argument :imageBase64, as: :image do
    type types.String
    description 'The base64 encoded version of the profile image to upload.'
  end

  argument :imageName, types.String, as: :image_file_name
end
