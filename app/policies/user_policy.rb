class UserPolicy < ApplicationPolicy
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
        scope.where(id: user.id)
      end
    end
  end

  def show?
    user.present? && user == record || user.present? && user.admin?
  end

  def update?
    user.present? && user == record || user.present? && user.admin?
  end
end
