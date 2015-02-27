class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
			t.string :place_id
			t.float :lat
			t.float :lng
			t.string :name
			t.float :rating
      t.timestamps null: false
    end
		add_index(:restaurants, :place_id)
  end
end
