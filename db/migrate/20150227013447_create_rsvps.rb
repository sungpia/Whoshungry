class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
			t.belongs_to :user
			t.belongs_to :vote
			t.integer :rsvp
      t.timestamps null: false
    end
		add_index(:rsvps, :user_id)
		add_index(:rsvps, :vote_id)
  end
end
