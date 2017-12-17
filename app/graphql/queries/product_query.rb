module Queries::ProductQuery
  def self.create(object_type)
    object_type.field :product do
      authorize! :show, policy: Product
      type Types::ProductType
      argument :id, !types.ID
      description 'Find a Product by ID'
      resolve ->(_obj, args, _ctx) { Product.find(args['id']) }
    end

    object_type.field :products, function: Resolvers::ProductResolver do
      authorize! :index, policy: Product
    end
  end
end
