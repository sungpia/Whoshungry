class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
			t.belongs_to :user
			t.string :login_type
			t.string :token
      t.timestamps null: false
    end
  end
end
