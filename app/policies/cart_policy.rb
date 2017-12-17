class CartPolicy < ApplicationPolicy
  def index?
    owner_or_admin?
  end

  def show?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def delete?
    owner_or_admin?
  end

  def current_cart?
    user.present?
  end

  private

  def owner_or_admin?
    record.user == user || user.admin?
  end
end
