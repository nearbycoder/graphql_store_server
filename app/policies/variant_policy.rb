class VariantPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user_admin?
  end

  def update?
    user_admin?
  end

  def delete?
    user_admin?
  end

  private

  def user_admin?
    user.present? && user.admin?
  end
end
