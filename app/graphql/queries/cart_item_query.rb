module Queries::CartItemQuery
  def self.create(object_type)
    object_type.field :current_cart_items do
      type types[Types::CartItemType]
      description 'Find current users CartItems'
      resolve ->(_obj, _args, ctx) {
        cart = ctx[:current_user].cart
        ctx[:pundit].authorize cart, :show?
        cart.cart_items
      }
    end

    object_type.field :cart_item do
      type Types::CartItemType
      argument :id, !types.ID
      description 'Find a CartItem by ID'
      resolve ->(_obj, args, ctx) {
        cart_item = CartItem.find(args['id'])
        ctx[:pundit].authorize cart_item, :show?
        cart_item
      }
    end

    object_type.field :cart_items, function: Resolvers::CartItemResolver
  end
end
