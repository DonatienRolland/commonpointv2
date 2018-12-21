class CreatePointGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :point_groups do |t|
      t.timestamps
    end
  end
end
