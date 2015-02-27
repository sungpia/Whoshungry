class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
			t.belongs_to :user, null: false, index: true
			t.string :os_type, null: false # ios, android, web
			t.string :push_id #can be null if it's webapp
      t.timestamps null: false
    end
  end
end
