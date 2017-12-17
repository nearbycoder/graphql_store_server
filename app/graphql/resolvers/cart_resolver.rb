class Resolvers::CartResolver < Resolvers::BaseSearchResolver
  description 'Find all Carts'

  type types[Types::CartType]

  scope { Cart.all }

  option :name, type: types.String, with: :apply_name_filter
  option :user_id, type: types.String, with: :apply_user_id_filter

  def apply_name_filter(scope, value)
    scope.where 'name ILIKE ?', escape_search_term(value)
  end

  def apply_user_id_filter(scope, value)
    scope.where 'user.id = ?', value
  end
end
