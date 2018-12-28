class TrackSessionsController < Devise::SessionsController
  after_action :after_login, :only => :create

  def after_login
    Visit.create!(user_id: current_user.id, user_email: current_user.email, company_id: current_user.company.id)
  end
end
