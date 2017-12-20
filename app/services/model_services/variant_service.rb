class ModelServices::VariantService < ModelServices::BaseModelService
  def create
    variant = Variant.new(args[:variant].to_h)
    authorize variant, :create?
    variant.save
    variant
  end

  def update
    variant = find_variant
    authorize variant, :update?
    variant.update(args[:variant].to_h)
    variant
  end

  def destroy
    variant = find_variant
    authorize variant, :delete?
    variant.destroy
    variant
  end

  private

  def find_variant
    Variant.find(args[:id])
  end
end
