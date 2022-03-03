class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :friend_one
      t.references :friend_two

      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :friend_one_id, primary_key: :id
    add_foreign_key :friendships, :users, column: :friend_two_id, primary_key: :id
  end
end
