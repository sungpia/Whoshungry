class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
	    t.belongs_to :user
			t.integer :pickup
			t.float :lat
			t.float :lng
      t.timestamps null: false
    end
  end
end
