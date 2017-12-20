class Resolvers::CartResolver < Resolvers::BaseSearchResolver
  description 'Find all Carts'

  type types[Types::CartType]

  OrderEnum = GraphQL::EnumType.define do
    name 'CartOrder'

    value 'NAME'
    value 'CREATED_AT'
    value 'UPDATED_AT'
  end

  scope { context[:pundit].policy_scope(Cart) }

  option :name, type: types.String, with: :apply_name_filter
  option :user_id, type: types.String, with: :apply_user_id_filter
  option :order_by, type: OrderEnum, default: 'NAME'

  def apply_name_filter(scope, value)
    scope.where 'name ILIKE ?', escape_search_term(value)
  end

  def apply_user_id_filter(scope, value)
    scope.where 'user.id = ?', value
  end

  def apply_order_by_with_name(scope)
    scope.order "name #{order_direction}"
  end
end
