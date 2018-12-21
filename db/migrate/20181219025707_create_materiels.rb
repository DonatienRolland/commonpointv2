class CreateMateriels < ActiveRecord::Migration[5.2]
  def change
    create_table :materiels do |t|
      t.string :title
      t.text :note
      t.references :participant, foreign_key: true
      t.references :evenement, foreign_key: true

      t.timestamps
    end
  end
end
