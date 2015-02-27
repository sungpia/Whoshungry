class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
			t.belongs_to :vote, index: true, null: false
			t.belongs_to :restaurant, index: true, null: false
			t.integer :count, default: 0
      t.timestamps null: false
    end
  end
end
