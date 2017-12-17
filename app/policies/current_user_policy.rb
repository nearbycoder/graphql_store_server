class CurrentUserPolicy < ApplicationPolicy
  def update?
    user.present?
  end
end
