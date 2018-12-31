class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.boolean :invitation_prive, null: true, default: true
      t.boolean :invitation_publique, null: true, default: true
      t.boolean :message, null: true, default: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
