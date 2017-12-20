class Resolvers::UserResolver < Resolvers::BaseSearchResolver
  description 'Find all Users'

  type types[Types::UserType]

  OrderEnum = GraphQL::EnumType.define do
    name 'UserOrder'

    value 'NAME'
    value 'EMAIL'
    value 'CREATED_AT'
    value 'UPDATED_AT'
  end

  scope { context[:pundit].policy_scope(User) }

  option :name, type: types.String, with: :apply_name_filter
  option :email, type: types.String, with: :apply_email_filter
  option :order_by, type: OrderEnum, default: 'NAME'

  def apply_name_filter(scope, value)
    scope.where 'name LIKE ?', escape_search_term(value)
  end

  def apply_email_filter(scope, value)
    scope.where 'email LIKE ?', escape_search_term(value)
  end

  def apply_order_by_with_name(scope)
    scope.order "name #{order_direction}"
  end

  def apply_order_by_with_email(scope)
    scope.order "email #{order_direction}"
  end
end
