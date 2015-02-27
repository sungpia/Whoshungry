class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	    t.integer :fb_id, index: true
	    t.string :name, null: false
	    t.string :picture
	    t.string :contact, null: false
      t.timestamps null: false
    end
  end
end
