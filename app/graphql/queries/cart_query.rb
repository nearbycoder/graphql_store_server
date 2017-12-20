module Queries::CartQuery
  def self.create(object_type)
    object_type.field :current_cart do
      type Types::CartType
      description 'Find the users Current Cart'
      resolve ->(_obj, _args, ctx) {
        cart = ctx[:current_user].cart
        ctx[:pundit].authorize cart, :show?
        cart
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
