class CartItemPolicy < ApplicationPolicy
  def index?
    owner_or_admin?
  end

  def show?
    owner_or_admin?
  end

  def create?
    record.user == user || user.admin?
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
