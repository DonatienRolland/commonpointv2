class RenameParticiantToParticipant < ActiveRecord::Migration[5.2]
  def change
     rename_table :particiants, :participants
  end
end
