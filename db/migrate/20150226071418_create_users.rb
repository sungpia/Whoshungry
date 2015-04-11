class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	    t.string :fb_id, index: true
	    t.string :name
	    t.string :picture
	    t.string :contact, unique: :true
	    t.string :role, default: "user"
	    t.string :email
	    t.string :password
	    t.boolean :registered, default: false
      t.timestamps null: false
    end
  end
end

