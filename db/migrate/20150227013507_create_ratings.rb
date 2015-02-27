class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
			t.belongs_to :user, index: true, null: false
			t.belongs_to :restaurant, index: true, null: false
			t.integer :rating
      t.timestamps null: false
    end
  end
end
