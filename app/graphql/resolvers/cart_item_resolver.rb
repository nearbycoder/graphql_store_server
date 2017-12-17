class Resolvers::CartItemResolver < Resolvers::BaseSearchResolver
  description 'Find all Cart Items'

  type types[Types::CartItemType]

  scope { CartItem.all }

  option :name, type: types.String, with: :apply_name_filter
  option :cart_id, type: types.String, with: :apply_cart_id_filter

  def apply_name_filter(scope, value)
    scope.where 'name ILIKE ?', escape_search_term(value)
  end

  def apply_cart_id_filter(scope, value)
    scope.where 'cart.id = ?', value
  end
end
