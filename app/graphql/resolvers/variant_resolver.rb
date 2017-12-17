class Resolvers::VariantResolver < Resolvers::BaseSearchResolver
  description 'Find all Variants'

  type types[Types::VariantType]

  scope { Variant.all }

  OrderEnum = GraphQL::EnumType.define do
    name 'VariantOrder'

    value 'NAME'
    value 'DESCRIPTION'
    value 'CREATED_AT'
    value 'UPDATED_AT'
  end

  option :name, type: types.String, with: :apply_name_filter
  option :description, type: types.String, with: :apply_description_filter
  option :order_by, type: OrderEnum, default: 'NAME'

  def apply_name_filter(scope, value)
    scope.where 'name ILIKE ?', escape_search_term(value)
  end

  def apply_description_filter(scope, value)
    scope.where 'description ILIKE ?', escape_search_term(value)
  end

  def apply_order_by_with_name(scope)
    scope.order "name #{order_direction}"
  end

  def apply_order_by_with_description(scope)
    scope.order "description #{order_direction}"
  end
end
