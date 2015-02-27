class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
			t.belongs_to :user
			t.string :os_type
			t.string :push_id
      t.timestamps null: false
    end
		add_index(:devices, :user_id)
  end
end
