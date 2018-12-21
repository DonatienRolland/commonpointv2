class CreateParticiants < ActiveRecord::Migration[5.2]
  def change
    create_table :particiants do |t|
      t.boolean :participe
      t.references :user, foreign_key: true
      t.references :evenement, foreign_key: true

      t.timestamps
    end
  end
end
