class EvenementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:participants).where(user_id: user.id)
    end
  end

  def show?
    true
  end


  def update_materiel?
    true
  end
end
