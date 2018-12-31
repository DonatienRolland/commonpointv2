class EvenementsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update_status_participant, :update_materiel]

  def index
    @user = User.find(params[:user_id])
    @user_all_evenements = policy_scope(Evenement)

    @activities = policy_scope(Evenement).collect{ |u| u.user_activity.activity.title}.insert(0, "Tous").uniq

    filtering(@user_all_evenements)
    @evenement = Evenement.new
    @no_icon = "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg"

    @months = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    @now = Time.zone.now.beginning_of_month
    @today = Date.today
  end

  def historique
    @user = User.find(params[:user_id])
    @today = Date.today
    all_evenements = Evenement.where('jour < ?', @today).joins(:participants).where(participants: { user_id: @user.id })
    @user_all_evenements = all_evenements
    @activities = all_evenements.collect{ |u| u.user_activity.activity.title}.insert(0, "Tous").uniq

    filtering(@user_all_evenements)

    @no_icon = "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg"

    @months = [ -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11]
    @now = Time.zone.now.beginning_of_month
    authorize @user
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
      redirect_to user_evenements_path(@user), flash: {alert: "Renseignez une activité et le type d'événement"}
    end
    authorize @user
  end

  def show
    @evenement = Evenement.find(params[:id])
    @user = current_user
    @message = Message.new
    @messages = Message.where(evenement: @evenement).order('created_at ASC')
    @participant = Participant.where(user: @user, evenement: @evenement).first
    @level = UserActivity.where(user: @user, activity: @evenement.activity).first.level
    # A changer
    @no_icon = "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg"
    @markers = [{
      lng: @evenement.adresse.nil? ? 2.333333 : @evenement.longitude,
      lat: @evenement.adresse.nil? ? 48.866667 : @evenement.latitude,
    }]
    @participants_are_coming = []
    @evenement.participants.where(participe: true).order_by_user_name.each do |participant|
      parti = {
        participant_id: participant.id,
        user_id: participant.user_id,
        level: UserActivity.where(user: participant.user, activity: @evenement.activity).first.level
      }
      @participants_are_coming << parti
    end
    authorize @evenement
  end
  # TODO before_destroy de participant a refaire

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
    authorize @user
  end

  def update
    @evenement = Evenement.find(params[:id])
    @user = @evenement.user
    if @evenement.update(evenement_params)
      update_participants(@evenement, current_user)
      @evenement.send_confirmation_of_creation_email
      # TODO verifier si la seconde date s'energriser
      if params[:second_date].present? && params[:second_date] != ""
        create_a_second_evenement_with(params[:second_date],params[:second_heur] , @evenement, current_user)
        redirect_to mes_evenements_evenement_path( @evenement ), flash: {notice: "Tout est en ordre"}
      else
        redirect_to evenement_path( @evenement ), flash: {notice: "Tout est en ordre"}
      end
    else
      redirect_to edit_evenement_path(@evenement), flash: {alert: "Assurez-vous d'avoir bien remplis tous les champs" }
    end
    authorize @user
  end

  def update_status_participant
    @evenement = Evenement.find(params[:id])
    @user = @evenement.user
    p "find evenement ok #{@evenement.id} et user #{@user.id}"
    p "params ====>>>>  #{params}"
    if !params[:status] || params[:status] == "false"
      materiels = Materiel.where(participant_id: params[:participant_id], evenement_id: params[:id])
      materiels.each do |materiel|
        materiel.participant = nil
        materiel.save
      end
    end

    participant = Participant.find(params[:participant_id]).update(participe: params[:status] )
    p "#{participant}"
    @evenement.check_if_full
    head :ok
    authorize @user
  end


  def update_materiel
    @evenement = Evenement.find(params[:id])
    params_value = params[:params_value]
    materiel = Materiel.find(params_value[:materiel])
    @user = User.find(params_value[:user])

    if params_value[:checked] == "true"
      p "ok you are checked"
      participant = Participant.where(user: @user, evenement: @evenement).first
    else
      p "ok unchecked"
      participant == nil
    end
      p "#{participant}"
    if materiel.update(participant: participant)
      p "All good dude"
    else
      p "error"
    end
    head :ok
    authorize @evenement
  end

  def update_boosted
    p "You in with #{params}"
    @user = User.find(params[:user_id])
    Evenement.where(id: params[:evenement_id]).update_all(boosted: params[:boosted] )
    head :ok
    p "All good"
    authorize @user
  end

  def destroy
    @evenement = Evenement.find(params[:id])
    @user = @evenement.user
    @evenement.destroy
    redirect_to user_evenements_path(@user)
    authorize @user
  end

  def mes_evenements
    @evenement = Evenement.find(params[:id])
    @user = @evenement.user
    @evenements = @evenement.point_group.evenements
    authorize @user
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
        evenement.check_if_full
      end

    end
  end

  def create_a_second_evenement_with(params_date, params_heure, evenement, user)
     date = Date.parse params_date
     heure = Time.parse params_heure
     heure = heure.strftime("%H:%M")
    if Evenement.where(jour: date, heur: heure, user: user, user_activity: evenement.user_activity ).count < 1
      new_evenement = Evenement.new(evenement.attributes.merge(jour: date, heur: heure ))
      new_evenement.id = nil
      new_evenement.save
      new_evenement.send_confirmation_of_creation_email
      evenement.participants.each do |participant|
        new_evenement.generate_participant(participant.user, participant.user === current_user ? true : nil)
      end
      evenement.materiels.each do |materiel|
        equi = Materiel.create!(materiel.attributes.merge(id: nil, evenement: new_evenement))
      end

    end
  end

  def evenement_params
    params.require(:evenement).permit(:user_activity_id, :type_of_evenement,
      :nombre_min, :nombre_max, :prix, :adresse,
      :user, :jour, :heur,
      materiels_attributes: Materiel.attribute_names.map(&:to_sym).push(:_destroy)
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

  def filtering(evenements)
    filtering_params(params).each do |key, value|
      @user_all_evenements = evenements.public_send(key, value) if value.present? && value != "Tous"
    end
  end

  def filtering_params(params)
    params.slice(:activity_title)
  end


end
