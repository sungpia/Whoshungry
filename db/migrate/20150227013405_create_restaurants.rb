class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
			t.string :place_id, index: true, null: false
			t.float :lat
			t.float :lng
			t.string :name
			t.string :picture
			t.float :rating
      t.timestamps null: false
    end
  end
end
