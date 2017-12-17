class User < ActiveRecord::Base
  rolify
  acts_as_paranoid
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  def admin?
    has_role? :admin
  end

  def member?
    has_role? :member
  end
end
