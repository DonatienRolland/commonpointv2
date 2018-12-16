class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :icon
      t.integer :total_user, default: 0
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
