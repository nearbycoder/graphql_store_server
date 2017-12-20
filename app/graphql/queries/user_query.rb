module Queries::UserQuery
  def self.create(object_type)
    object_type.field :current_user do
      type Types::UserType
      description 'get current_user'
      resolve ->(_obj, _args, ctx) do
        @current_user = ctx[:current_user]
        return GraphQL::ExecutionError.new('Not Authorized') unless @current_user
        @current_user
      end
    end

    object_type.field :user do
      type Types::UserType
      argument :id, !types.ID
      description 'Find a User by ID'
      resolve ->(_obj, args, ctx) {
        user = User.find(args['id'])
        ctx[:pundit].authorize user, :show?
        user
      }
    end

    object_type.field :users, function: Resolvers::UserResolver
  end
end
