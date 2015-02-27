class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
			t.belongs_to :group, index: true, null: false
			t.string :type
			t.string :name
			t.integer :expires_in
			t.belongs_to :restaurant, null: true
			t.datetime :expires_at
      t.timestamps null: false
    end
  end
end
