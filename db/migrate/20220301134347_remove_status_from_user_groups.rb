class RemoveStatusFromUserGroups < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_groups, :status, :string
  end
end
