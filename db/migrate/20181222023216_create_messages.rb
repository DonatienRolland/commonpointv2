class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :evenement, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
