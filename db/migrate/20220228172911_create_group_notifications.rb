class CreateGroupNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :group_notifications do |t|
      t.references :group, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
