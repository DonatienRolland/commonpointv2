class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :evenement

  has_many :messages, dependent: :destroy

  scope :order_by_user_name, -> { includes(:user).order('users.prenom')}

  scope :are_coming, -> { where(participe: true)}
  # before_destroy :uncheck_materiel

  def uncheck_materiel
    self.materiels.each do |materiel|
      materiel.participant_id = nil
      materiel.save
    end
  end


end

