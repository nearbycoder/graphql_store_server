class ProductPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
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
