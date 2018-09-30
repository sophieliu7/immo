class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :goal
      t.string :old_new_type
      t.string :house_type
      t.string :location
      t.integer :min_budget
      t.integer :max_budget
      t.integer :min_living_space
      t.integer :max_living_space
      t.integer :min_land_area
      t.integer :max_land_area
      t.integer :rooms
      t.integer :bedrooms

      t.timestamps
    end
  end
end
