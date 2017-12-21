module Mutations::CartMutation
  def self.create(object_type)
    object_type.field :update_cart, Types::CartType do
      argument :id, !types.ID
      description 'Update a cart'
      argument :cart, CartUpdateType
      resolve ->(_root, args, ctx) {
        ModelServices::CartService.new(args, ctx).update
      }
    end

    object_type.field :delete_cart, Types::CartType do
      argument :id, !types.ID
      description 'Delete a cart'
      resolve ->(_root, args, ctx) {
        ModelServices::CartService.new(args, ctx).destroy
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
