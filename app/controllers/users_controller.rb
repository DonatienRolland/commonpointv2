class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    # @user_activities = @user.user_activities.order('level desc')
    @user_activities = []
    # authorize @user
    Activity.are_activities_with(@user).all.order('title ASC').each do |activity|
      activity = {
        id: activity.id,
        title: activity.title,
        icon: activity.icon? ? activity.icon : "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg",
        category_id: activity.category_id,
        user_activity_id: activity.is_an_activity_with(@user).present? ? activity.is_an_activity_with(@user).id : false
      }
      @user_activities << activity
    end
  end
end
