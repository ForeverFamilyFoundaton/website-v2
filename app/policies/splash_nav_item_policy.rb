class SplashNavItemPolicy < ApplicationPolicy
  def reorder?
    user.admin?
  end

  def scoped_collection?
    user.admin?
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
