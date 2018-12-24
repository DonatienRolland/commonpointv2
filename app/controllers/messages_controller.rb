class MessagesController < ApplicationController

  def create
    @evenement = Evenement.find(params[:evenement_id])
    @user = current_user
    participant = Participant.where(user: @user, evenement: @evenement)
    @participant = participant.first
    @message = Message.new(message_params)
    @message.evenement = @evenement
    @message.participant = @participant
    if @message.save
      respond_to do |format|
        format.html { redirect_to evenement_path(@evenement) }
        format.js  # <-- will render `app/views/messages/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'evenements/show' }
        format.js  # <-- idem
      end
    end
     authorize @user
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
