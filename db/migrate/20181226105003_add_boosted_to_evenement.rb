class AddBoostedToEvenement < ActiveRecord::Migration[5.2]
  def change
    add_column :evenements, :boosted, :boolean, null: false, default: false
  end
end
