class Resolvers::ProductResolver < Resolvers::BaseSearchResolver
  description 'Find all Products'

  type types[Types::ProductType]

  scope { Product.all }

  option :name, type: types.String, with: :apply_name_filter
  option :description, type: types.String, with: :apply_description_filter

  def apply_name_filter(scope, value)
    scope.where 'name ILIKE ?', escape_search_term(value)
  end

  def apply_description_filter(scope, value)
    scope.where 'description ILIKE ?', escape_search_term(value)
  end
end
