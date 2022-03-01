class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.string :link
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
