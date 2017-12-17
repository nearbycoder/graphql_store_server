module Queries::CartQuery
  def self.create(object_type)
    object_type.field :current_cart do
      authorize! :current_cart, policy: Cart
      type Types::CartType
      description 'Find the users Current Cart'
      resolve ->(_obj, _args, ctx) { ctx[:current_user].cart }
    end

    object_type.field :cart do
      authorize! :show, policy: Cart
      type Types::CartType
      argument :id, !types.ID
      description 'Find a Cart by ID'
      resolve ->(_obj, args, _ctx) { Cart.find(args['id']) }
    end

    object_type.field :carts, function: Resolvers::CartResolver do
      authorize! :index, policy: Cart
    end
  end
end
