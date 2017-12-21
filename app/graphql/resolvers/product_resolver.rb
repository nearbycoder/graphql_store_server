class Resolvers::ProductResolver < Resolvers::BaseSearchResolver
  description 'Find all Products'

  type types[Types::ProductType]

  OrderEnum = GraphQL::EnumType.define do
    name 'ProductOrder'

    value 'ID'
    value 'NAME'
    value 'DESCRIPTION'
    value 'CREATED_AT'
    value 'UPDATED_AT'
  end

  scope do
    context[:model_name] = 'products'
    get_scope(Product)
  end

  option :name, type: types.String, with: :apply_name_filter
  option :description, type: types.String, with: :apply_description_filter
  option :order_by, type: OrderEnum

  def apply_name_filter(scope, value)
    scope.where 'products.name ILIKE ?', escape_search_term(value)
  end

  def apply_description_filter(scope, value)
    scope.where 'products.description ILIKE ?', escape_search_term(value)
  end

  def apply_order_by_with_name(scope)
    scope.order "products.name #{order_direction}"
  end

  def apply_order_by_with_description(scope)
    scope.order "products.description #{order_direction}"
  end
end
