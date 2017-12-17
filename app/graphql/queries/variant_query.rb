module Queries::VariantQuery
  def self.create(object_type)
    object_type.field :variant do
      authorize! :show, policy: Variant
      type Types::VariantType
      argument :id, !types.ID
      description 'Find a Variant by ID'
      resolve ->(_obj, args, _ctx) { Variant.find(args['id']) }
    end

    object_type.field :variants, function: Resolvers::VariantResolver do
      authorize! :index, policy: Variant
    end
  end
end
