class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
			t.string :code, null: false
			t.string :contact, null: false
      t.timestamps null: false
    end
  end
end
