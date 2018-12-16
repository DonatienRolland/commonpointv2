class AddPrenomToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prenom, :string
    add_column :users, :nom, :string
    add_column :users, :avatar, :string
    add_column :users, :telephone, :string
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :rh, :boolean, null: false, default: false
    add_reference :users, :company, foreign_key: true
  end
end

