class AddStatusToUserGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :user_groups, :status, :boolean, default: false
  end
end
