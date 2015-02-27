class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
			t.belongs_to :user
			t.belongs_to :restaurant
			t.integer :rating
      t.timestamps null: false
    end
		add_index(:ratings, :user_id)
		add_index(:ratings, :restaurant_id)
  end
end
