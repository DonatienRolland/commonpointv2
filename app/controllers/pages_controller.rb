class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
    @company = @user.company
    @no_icon = "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg"
    @evenements = Evenement.all.joins(:participants).where(user: @user)
    @months = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    @now = Time.zone.now.beginning_of_month
    @today = Date.today
  end
end
