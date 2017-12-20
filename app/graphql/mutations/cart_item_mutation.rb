module Mutations::CartItemMutation
  def self.create(object_type)
    object_type.field :create_cart_item, Types::CartItemType do
      description 'Create a cart item'
      argument :cart_item, CartItemCreateType
      resolve ->(_cart_item, args, ctx) {
        ModelServices::CartItemService.new(args, ctx).create
      }
    end

    object_type.field :update_cart_item, Types::CartItemType do
      argument :id, !types.ID
      description 'Update a cart item'
      argument :cart_item, CartItemUpdateType
      resolve ->(_cart_item, args, ctx) {
        ModelServices::CartItemService.new(args, ctx).update
      }
    end

    object_type.field :delete_cart_item, Types::CartItemType do
      argument :id, !types.ID
      description 'Delete a cart item'
      resolve ->(_cart_item, args, ctx) {
        ModelServices::CartItemService.new(args, ctx).destroy
      }
    end
  end
end

CartItemCreateType = GraphQL::InputObjectType.define do
  name 'CartItemCreateType'
  description 'Properties for creating a Cart Item'
  argument :cartId, !types.ID, as: :cart_id do
    description 'Cart id to attach to.'
  end

  argument :variantId, !types.ID, as: :variant_id do
    description 'Variant id of cart item.'
  end

  argument :quantity, !types.Int do
    description 'quantity of the cart item.'
  end
end

CartItemUpdateType = GraphQL::InputObjectType.define do
  name 'CartItemUpdateType'
  description 'Properties for creating a Cart Item'

  argument :quantity, !types.Int do
    description 'quantity of the cart item.'
  end
end
