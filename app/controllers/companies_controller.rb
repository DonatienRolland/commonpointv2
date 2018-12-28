class CompaniesController < ApplicationController
  def edit
    @company = Company.find(params[:id])
    @user = current_user

    @evenements = []
        @start =

    @evenements_this_week = Evenement.from_to(Date.today.beginning_of_week, Date.today.end_of_week).count
    @company.evenements.a_venir.order('jour').each do |evenement|
      if evenement.company == @company
        evenement_to_push = {
          evenement_id: evenement.id,
          activity: evenement.activity_title,
          nombre_participant: evenement.participants.are_coming.count,
          status: evenement.full ? "Complet" : "Disponible",
          date: evenement.jour.nil? ? "none": evenement.jour.strftime("%d/%m/%Y"),
          boosted: evenement.boosted
        }
        @evenements << evenement_to_push
      end
    end

    activities = []
    @company.evenements.all.each do |evenement|
      if !activities.include?(evenement.activity_title)
        activities << evenement.activity_title
      end
    end
    stat_activity = []
    activities.each do |activity|
      act = {
        "label": activity,
        "value": @company.evenements.activity_title(activity).count,
        "link": "none"
      }
      stat_activity << act
    end
    stat_activity = stat_activity.sort_by { |hsh| hsh[:value] }
    @stat_activity = stat_activity.reverse

    # TODO visite créer, il faut maintenant le lier au tableau en gardant la periode comme flexibilité
    # TODO ajouter un column à un evenement pour le booster

    @perdiode = [ "semaine", "mois", "année", "personnalisé" ]
    authorize @user

  end


  def show
    @company = Company.find(params[:id])
    @user = current_user
    @no_icon = "https://res.cloudinary.com/dj7bq8py7/image/upload/c_scale,h_84,q_99/v1541578509/logo.jpg"
    @evenements = Evenement.all.joins(:participants).where(user: @user, type_of_evenement: "Publique").boosted
    @months = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    @now = Time.zone.now.beginning_of_month
    @today = Date.today
    authorize @user
  end
end
