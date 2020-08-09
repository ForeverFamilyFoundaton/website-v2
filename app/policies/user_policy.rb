class UserPolicy < ApplicationPolicy
  def soft_delete?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
