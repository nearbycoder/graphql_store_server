class CartItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :variant
  belongs_to :cart
end
