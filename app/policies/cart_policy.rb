class CartPolicy < ApplicationPolicy
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
        scope.where(user: user)
      end
    end
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
