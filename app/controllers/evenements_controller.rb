class EvenementsController < ApplicationController


  def index
    @user = User.find(params[:user_id])
    @evenement = Evenement.new
  end

  def create
    @user = User.find(params[:user_id])
    @evenement = Evenement.new(evenement_params)
    user_activity = UserActivity.where(user: @user, activity_id: activity_params).first
    @evenement.user_activity = user_activity
    @evenement.user = @user
    # raise
    if @evenement.save
      @evenement.generate_participant(@user, true)
      redirect_to edit_evenement_path(@evenement), flash: {notice: "Votre evenement a été créé. Veuilliez compléter les infos manquantes"}
    else
      render new
    end
  end

  def show
    @evenement = Evenement.find(params[:id])
    @user = @evenement.user
  end

  def edit
    @evenement = Evenement.find(params[:id])
    @markers = [{
      lng: @evenement.adresse.nil? ? 2.333333 : @evenement.longitude,
      lat: @evenement.adresse.nil? ? 48.866667 : @evenement.latitude,
    }]
    @evenement.materiels.count == 0 ? 1.times { @evenement.materiels.build } : 0.times { @evenement.materiels.build }
    @user = @evenement.user
    # set participants
    @users = []
    @stars = []

    UserActivity.where(activity: @evenement.activity).each do |user_activity|
      user = {
        user_id: user_activity.user.id,
        level: user_activity.level
      }
      @stars[user_activity.level - 1] =+ 1
      @users << user
    end
    @participants = []
    Participant.where(evenement: @evenement).each do |participant|
      @participants << participant.user_id
    end
  end

  def update
    @evenement = Evenement.find(params[:id])
    if @evenement.update(evenement_params)
      update_participants(@evenement, current_user)
      if params[:second_date].present? && params[:second_date] != ""
        create_a_second_point_with(params[:second_date],params[:second_heur] , @evenement, current_user)
        redirect_to mes_evenements_evenement_path( @evenement ), flash: {notice: "Tout est en ordre"}
      else
        redirect_to evenement_path( @evenement ), flash: {notice: "Tout est en ordre"}
      end
    else
      redirect_to edit_evenement_path(@evenement), flash: {alert: "Assurez-vous d'avoir bien remplis tous les champs" }
    end
    # authorize @user
  end

  # TODO before_destroy de participant a refaire


  def destroy

  end

  def mes_evenements
    @evenement = Evenement.find(params[:id])
    @user = @evenement.user
    @evenements = @evenement.point_group.evenements
  end

private

  def difference_between_new_and_existing_user_ids(participant_ids, set_new_participants)
    user_ids = []
    participant_ids.each do |id|
      user_id = Participant.find(id).user_id
      user_ids << user_id
    end
    reject1 = set_new_participants.reject{|x| user_ids.include? x}
    reject2 = user_ids.reject{|x| set_new_participants.include? x}
    return reject1 + reject2
  end

  def update_participants(evenement, current_user)
    participant_ids = difference_between_new_and_existing_user_ids(evenement.participant_ids, set_participants)
    participant_ids.each do |participant_id|
      if participant_id.present?
        user = User.find(participant_id.to_i)
        participant = Participant.where(user: participant_id.to_i, evenement: evenement).first
        if participant.nil?
          evenement.generate_participant(user, user === current_user ? true : nil)
        else
          evenement.delete_participant(user)
        end
      end

    end
  end

  def create_a_second_point_with(date, heure, evenement, user)
    if Evenement.where(jour: date, heur: heure, user: user, user_activity: evenement.user_activity ).count < 1
      new_evenement = Evenement.new(evenement.attributes.merge(jour: date, heur: heure ))
      new_evenement.id = nil
      # new_evenement.point_group_id = evenement.point_group_id
      new_evenement.save
      evenement.materiels.each do |materiel|
        equi = Materiel.create!(materiel.attributes.merge(id: nil, evenement: new_evenement))
      end
    end
  end

  def evenement_params
    params.require(:evenement).permit(:user_activity_id, :type_of_evenement,
      :nombre_min, :nombre_max, :prix, :adresse,
      :user, :jour, :heur,
      # materiels_attributes: Materiel.attribute_names.map(&:to_sym).push(:_destroy)
      materiels_attributes: [ :id, :title]
    )
  end

  def set_participants
    a = params[:participants]
    # renvoi une string d'id
    b = a.split(",")
    b.delete("")
    return b
  end

  def activity_params
    params[:evenement][:user_activity].to_i
  end
end
