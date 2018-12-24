class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.order('title ASC')
    end
  end
end
