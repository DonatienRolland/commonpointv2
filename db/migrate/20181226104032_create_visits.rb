class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.string :user_email

      t.timestamps
    end
  end
end
