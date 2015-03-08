class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	    t.string :fb_id, index: true
	    t.string :name, null: false
	    t.string :picture
	    t.string :contact, null: false
	    t.string :role, default: "user"
	    t.string :email, null: false
	    t.string :password
      t.timestamps null: false
    end
  end
end

