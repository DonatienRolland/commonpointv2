class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :evenement

  # before_destroy :uncheck_materiel

  def uncheck_materiel
    self.materiels.each do |materiel|
      materiel.participant_id = nil
      materiel.save
    end
  end

end

