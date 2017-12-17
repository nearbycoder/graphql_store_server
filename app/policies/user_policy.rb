class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def show?
    user.present? && user.admin?
  end

  def update?
    user.present? && user == record
  end
end
