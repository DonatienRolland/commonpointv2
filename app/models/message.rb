class Message < ApplicationRecord
  belongs_to :evenement
  belongs_to :participant
  validates :content, presence: true





  def send_to_all_participants(sender)
    self.evenement.participants.each do |participant|
      user = participant.user
      if user != sender && user.notification.message
        EvenementMailer.new_message(self.id, user.id, self.evenement_id).deliver_later
      end
    end
  end
end
