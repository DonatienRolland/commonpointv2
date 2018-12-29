class UserActivitiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @user = current_user
    @no_icon = "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg"
    if params[:act]
      @act_id = params[:act]
      @activity = Activity.find(@act_id)
      @random = params[:random]
      @user_activity =  UserActivity.where(user: @user, activity_id: @act_id ).first
    end
    respond_to do |format|
      format.html
      format.js
    end
    authorize @user
  end

  def create
    @user = User.find(params[:user_id])
    @user_activity = UserActivity.new(activity_params)
    @user_activity.user = @user
    if @user_activity.save
      act = @user_activity.activity
      act.total_user += 1
      act.save
      act_title = @user_activity.activity.title
      evenements = Evenement.activity_title(act_title).a_venir.where(full: false, type_of_evenement:"Publique")
      evenements.each do |evenement|
        evenement.generate_participant(@user, nil)
      end
      redirect_to user_activities_path(@user)
    else
      render :index
    end

    authorize @user

  end

  def update
    @user_activity = UserActivity.find(params[:id])
    @user = @user_activity.user
    if @user_activity.update(activity_params)
      redirect_to user_activities_path(@user)
    else
      render new
    end
    authorize @user
  end

  def destroy
    @user_activity = UserActivity.find(params[:id])
    @user = @user_activity.user
    @user_activity.destroy
    respond_to do |format|
      format.html { redirect_to user_activities_path(@user) }
      format.js
    end
    authorize @user
  end

  private

  def activity_params
    params.require(:user_activity).permit(:level, :information, :activity_id)
  end
end
