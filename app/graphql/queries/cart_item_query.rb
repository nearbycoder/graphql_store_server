module Queries::CartItemQuery
  def self.create(object_type)
    object_type.field :current_cart_items do
      authorize! :show, policy: CartItem
      type Types::CartItemType
      argument :id, !types.ID
      description 'Find a CartItem by ID'
      resolve ->(_obj, _args, ctx) { ctx[:current_user].cart.cart_items }
    end

    object_type.field :cart_item do
      authorize! :show, policy: CartItem
      type Types::CartItemType
      argument :id, !types.ID
      description 'Find a CartItem by ID'
      resolve ->(_obj, args, _ctx) { CartItem.find(args['id']) }
    end

    object_type.field :cart_items, function: Resolvers::CartItemResolver do
      authorize! :index, policy: CartItem
    end
  end
end
