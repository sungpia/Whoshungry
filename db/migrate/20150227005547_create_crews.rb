class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
			t.belongs_to :user, index: true, null: false
			t.belongs_to :group, index: true, null: false
      t.timestamps null: false
    end
  end
end
