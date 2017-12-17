module Mutations::CartItemMutation
  def self.create(object_type)
    object_type.field :create_cart_item, Types::CartItemType do
      authorize! ->(_cart_item, args, ctx) { CartItemPolicy.new(ctx[:current_user], Cart.find(args[:cart_item][:cart_id])).create? }
      description 'Create a Cart Item'
      argument :cart_item, CartItemCreateType
      resolve ->(_cart_item, args, _ctx) {
        cart = Cart.find(args[:cart_item][:cart_id])
        cart_item = cart.cart_items.create(args[:cart_item].to_h)
        cart.update_price
        cart_item
      }
    end

    object_type.field :update_cart_item, Types::CartItemType do
      authorize! ->(_cart_item, args, ctx) { CartItemPolicy.new(ctx[:current_user], CartItem.find(args[:id])).update? }
      argument :id, !types.ID
      description 'Update a Cart Item'
      argument :cart_item, CartItemUpdateType
      resolve ->(_cart_item, args, _ctx) {
        cart_item = CartItem.find(args[:id])
        cart_item.update(args[:cart_item].to_h)
        cart_item.cart.update_price
        cart_item
      }
    end

    object_type.field :delete_cart_item, Types::CartItemType do
      authorize! ->(_cart_item, args, ctx) { CartItemPolicy.new(ctx[:current_user], CartItem.find(args[:id])).delete? }
      argument :id, !types.ID
      description 'Delete a Cart Item'
      resolve ->(_cart_item, args, _ctx) {
        cart_item = CartItem.find(args[:id])
        cart_item.destroy
        cart_item.cart.update_price
        cart_item
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
