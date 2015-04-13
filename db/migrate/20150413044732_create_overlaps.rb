class CreateOverlaps < ActiveRecord::Migration
  def change
    create_table :overlaps do |t|
			t.integer :overlap, default: 0
			t.belongs_to :user
			t.belongs_to :choice
      t.timestamps null: false
    end
  end
end
