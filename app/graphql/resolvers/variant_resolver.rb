class Resolvers::VariantResolver < Resolvers::BaseSearchResolver
  description 'Find all Variants'

  type types[Types::VariantType]

  OrderEnum = GraphQL::EnumType.define do
    name 'VariantOrder'

    value 'ID'
    value 'NAME'
    value 'DESCRIPTION'
    value 'CREATED_AT'
    value 'UPDATED_AT'
  end

  scope do
    context[:model_name] = 'variants'
    get_scope(Variant)
  end

  option :name, type: types.String, with: :apply_name_filter
  option :description, type: types.String, with: :apply_description_filter
  option :order_by, type: OrderEnum

  def apply_name_filter(scope, value)
    scope.where 'variants.name ILIKE ?', escape_search_term(value)
  end

  def apply_description_filter(scope, value)
    scope.where 'variants.description ILIKE ?', escape_search_term(value)
  end

  def apply_order_by_with_name(scope)
    scope.order "variants.name #{order_direction}"
  end

  def apply_order_by_with_description(scope)
    scope.order "variants.description #{order_direction}"
  end
end
