class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :nom
      t.string :adresse
      t.string :description
      t.float :latitude
      t.float :longitude
      t.string :icon
      t.string :email_domain
      t.timestamps
    end
  end
end
