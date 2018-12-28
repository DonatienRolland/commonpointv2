class AddComanpyIdToVisit < ActiveRecord::Migration[5.2]
  def change
    add_column :visits, :company_id, :integer
  end
end
