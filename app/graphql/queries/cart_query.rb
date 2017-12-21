module Queries::CartQuery
  def self.create(object_type)
    object_type.field :current_cart do
      type Types::CartType
      description 'Find the users Current Cart'
      resolve ->(_obj, _args, ctx) {
        if ctx[:current_user]
          ctx[:current_user].default_cart
        else
          raise Pundit::NotAuthorizedError
        end
      }
    end

    object_type.field :cart do
      type Types::CartType
      argument :id, !types.ID
      description 'Find a Cart by ID'
      resolve ->(_obj, args, ctx) {
        cart = Cart.find(args['id'])
        ctx[:pundit].authorize cart, :show?
        cart
      }
    end

    object_type.field :carts, function: Resolvers::CartResolver
  end
end
