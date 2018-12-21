class CreateEvenements < ActiveRecord::Migration[5.2]
  def change
    create_table :evenements do |t|
      t.decimal :prix
      t.integer :nombre_min
      t.integer :nombre_max
      t.string :adresse
      t.integer :type_of_evenement
      t.date :jour
      t.time :heur
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true
      t.references :user_activity, foreign_key: true
      t.boolean :full, null: false, default: false

      t.timestamps
    end
  end
end
