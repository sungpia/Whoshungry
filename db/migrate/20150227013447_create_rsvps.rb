class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
			t.belongs_to :user, index: true, null: false
			t.belongs_to :vote, index: true, null: false
			t.integer :rsvp
      t.timestamps null: false
    end
  end
end
