class User < ActiveRecord::Base
  rolify
  acts_as_paranoid
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :carts, dependent: :destroy

  def cart
    default_cart
  end

  def cart=(val)
    default_cart.update(val)
  end

  def default_cart
    active_cart = carts.find_by(active: true)
    if active_cart.present?
      active_cart
    else
      carts.create(name: "Cart ##{carts.count + 1}")
    end
  end

  def admin?
    has_role? :admin
  end

  def member?
    has_role? :member
  end
end
