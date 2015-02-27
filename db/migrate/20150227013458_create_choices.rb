class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
			t.belongs_to :vote
			t.belongs_to :restaurant
			t.integer :count, default: 0
      t.timestamps null: false
    end
		add_index(:choices, :vote_id)
		add_index(:choices, :restaurant_id)
  end
end
