class CreateFavouriteEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
