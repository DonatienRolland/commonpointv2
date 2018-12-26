class CompaniesController < ApplicationController
  def edit
    @company = Company.find(params[:id])
    @user = current_user

    @evenements = []

    Evenement.a_venir.order('jour').each do |evenement|
      if evenement.company == @company
        evenement_to_push = {
          evenement_id: evenement.id,
          activity: evenement.activity_title,
          nombre_participant: evenement.participants.are_coming.count,
          status: evenement.full ? "Complet" : "Disponible",
          date: evenement.jour.nil? ? "none": evenement.jour.strftime("%d/%m/%Y")
        }
        @evenements << evenement_to_push
      end
    end

    activities = []
    Evenement.all.each do |evenement|
      if evenement.company == @company && !activities.include?(evenement.activity_title)
        activities << evenement.activity_title
      end
    end
    stat_activity = []
    activities.each do |activity|
      act = {
        "label": activity,
        "value": Evenement.activity_title(activity).count,
        "link": "none"
      }
      stat_activity << act
    end
    stat_activity = stat_activity.sort_by { |hsh| hsh[:value] }
    @stat_activity = stat_activity.reverse

    @perdiode = ["journée", "semaine", "mois", "année" ]
    authorize @user
  end
end
