class EvenementMailer < ApplicationMailer


  def creation_confirmation(evenement_id, user_id)
    @evenement = Evenement.find(evenement_id)
    @user = User.find(user_id)
    @type_of_evenement = @evenement.type_of_evenement

    mail(
      to:       @user.email,
      subject:  "L'événement #{@evenement.activity_title} a été créé en #{@type_of_evenement}!"
    )
  end

  def invitation_evenement(user_id, evenement_id)
    @user = User.find(user_id)
    @evenement = Evenement.find(evenement_id)

    mail(
      to:       @user.email,
      subject:  "Nouvelle invitation sur Common Point"
    )
  end


  def new_message(message_id, user_id, evenement_id)
    @evenement = Evenement.find(evenement_id)
    @user = User.find(user_id)
    @message = Message.find(message_id)
    mail(
      to:       @user.email,
      subject:  "Nouvelle notification Common Point"
    )

  end

end
