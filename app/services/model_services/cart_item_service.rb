class ModelServices::CartItemService < ModelServices::BaseModelService
  def create
    cart = find_cart
    cart_item = cart.cart_items.new(args[:cart_item].to_h)
    authorize cart_item, :create?
    cart_item.save
    cart.update_price
    cart_item
  end

  def update
    cart_item = find_cart_item
    authorize cart_item, :update?
    cart_item.update(args[:cart_item].to_h)
    cart_item.cart.update_price
    cart_item
  end

  def destroy
    cart_item = find_cart_item
    authorize cart_item, :delete?
    cart_item.destroy
    cart_item.cart.update_price
    cart_item
  end

  private

  def find_cart
    Cart.find(args[:cart_item][:cart_id])
  end

  def find_cart_item
    CartItem.find(args[:id])
  end
end
