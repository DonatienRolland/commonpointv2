class AddReferenceToEvenement < ActiveRecord::Migration[5.2]
  def change
    add_reference :evenements, :point_group, foreign_key: true
  end
end

