class Resolvers::CartItemResolver < Resolvers::BaseSearchResolver
  description 'Find all Cart Items'

  type types[Types::CartItemType]

  OrderEnum = GraphQL::EnumType.define do
    name 'CartItemOrder'

    value 'ID'
    value 'CREATED_AT'
    value 'UPDATED_AT'
  end

  scope do
    context[:model_name] = 'cart_items'
    get_scope(CartItem)
  end

  option :name, type: types.String, with: :apply_name_filter
  option :cart_id, type: types.String, with: :apply_cart_id_filter
  option :order_by, type: OrderEnum

  def apply_name_filter(scope, value)
    scope.where 'cart_items.name ILIKE ?', escape_search_term(value)
  end

  def apply_cart_id_filter(scope, value)
    scope.where 'cart.id = ?', value
  end

  def apply_order_by_with_name(scope)
    scope.order "cart_items.name #{order_direction}"
  end
end
