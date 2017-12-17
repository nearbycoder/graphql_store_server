class Cart < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def update_price
    self.total_price = cart_items.map { |item| item.variant.price * item.quantity }.reduce(0, :+)
  end
end
