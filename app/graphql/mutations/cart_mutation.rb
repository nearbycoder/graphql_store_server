module Mutations::CartMutation
  def self.create(object_type)
    object_type.field :update_cart, Types::CartType do
      authorize! ->(_cart, args, ctx) { CartPolicy.new(ctx[:current_user], Cart.find(args[:id])).update? }
      argument :id, !types.ID
      description 'Update a Cart'
      argument :cart, CartUpdateType
      resolve ->(_cart, args, _ctx) {
        cart = Cart.find(args[:id])
        cart.update(args[:Cart].to_h)
        cart
      }
    end

    object_type.field :delete_cart, Types::CartType do
      authorize! ->(_cart, args, ctx) { CartPolicy.new(ctx[:current_user], Cart.find(args[:id])).delete? }
      argument :id, !types.ID
      description 'Delete a Cart'
      resolve ->(_cart, args, _ctx) {
        cart = Cart.find(args[:id])
        cart.destroy
        cart
      }
    end
  end
end

CartUpdateType = GraphQL::InputObjectType.define do
  name 'CartUpdateType'
  description 'Properties for updating a Cart'

  argument :name, !types.String do
    description 'Name of the cart.'
  end
end
