class AddLicenceToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :licence, :integer
  end
end
