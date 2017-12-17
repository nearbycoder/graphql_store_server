class Resolvers::UserResolver < Resolvers::BaseSearchResolver
  description 'Find all Users'

  type types[Types::UserType]

  scope { User.all }

  option :name, type: types.String, with: :apply_name_filter
  option :email, type: types.String, with: :apply_email_filter

  def apply_name_filter(scope, value)
    scope.where 'name LIKE ?', escape_search_term(value)
  end

  def apply_email_filter(scope, value)
    scope.where 'email LIKE ?', escape_search_term(value)
  end
end
