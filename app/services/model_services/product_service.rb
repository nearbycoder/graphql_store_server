class ModelServices::ProductService < ModelServices::BaseModelService
  def create
    product = Product.new(args[:product].to_h)
    authorize product, :create?
    product.save
    product
  end

  def update
    product = find_product
    authorize product, :update?
    product.update(args[:product].to_h)
    product
  end

  def destroy
    product = find_product
    authorize product, :delete?
    product.destroy
    product
  end

  private

  def find_product
    Product.find(args[:id])
  end
end
