class ModelServices::CartService < ModelServices::BaseModelService
  def update
    cart = find_cart
    authorize cart, :update?
    cart.update(args[:cart].to_h)
    cart
  end

  def destroy
    cart = Cart.find(args[:id])
    authorize cart, :delete?
    cart.destroy
    cart
  end

  private

  def find_cart
    Cart.find(args[:id])
  end
end
