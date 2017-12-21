class CartItemPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:cart).merge(Cart.where(user: user))
      end
    end
  end

  def show?
    owner_or_admin?
  end

  def create?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def delete?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    record.cart.user == user || user.admin?
  end
end
