class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	    t.integer :fb_id
	    t.string :name
	    t.string :picture
	    t.string :contact
      t.timestamps null: false
    end
		add_index(:users, :fb_id)
  end
end
