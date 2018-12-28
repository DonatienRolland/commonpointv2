class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    is_user_the_owner_or_admin?
  end

  def update?
    is_user_the_owner_or_admin?
  end

  def mes_evenements?
    is_user_the_owner_or_admin?
  end

  def historique?
    is_user_the_owner_or_admin?
  end

  def update_status_participant?
    user == record || user.admin?
  end

  def destroy?
    user == record || user.admin?
  end

  def visitors_by_months?
    user == record || user.admin?
  end

  def visitors_by_days?
    user == record || user.admin?
  end

  def visitors_by_weeks?
    user == record || user.admin?
  end
  def switchPeriod?
    user == record || user.admin?
  end

  def update_boosted?
    user.rh? || user.admin?
  end


  private

  def is_user_the_owner_or_admin?
    user == record || user.admin?
  end
end
