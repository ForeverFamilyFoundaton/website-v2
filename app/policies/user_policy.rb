class UserPolicy < ApplicationPolicy
  def soft_delete?
    user.admin?
  end

  def un_soft_delete?
    user.admin?
  end

  def confirm?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
