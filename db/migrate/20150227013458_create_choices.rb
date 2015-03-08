class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
			t.belongs_to :vote, index: true
			t.belongs_to :restaurant, index: true
			t.integer :count, default: 0
      t.timestamps null: false
    end
  end
end
