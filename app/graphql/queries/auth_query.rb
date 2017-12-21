module Queries::AuthQuery
  def self.create(object_type)
    object_type.field :valid_token do
      type Types::UserType
      description 'Validate User'
      resolve ->(_obj, _args, ctx) do
        user = ctx[:current_user]

        user if user
      end
    end
  end
end
