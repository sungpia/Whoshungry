class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
			t.belongs_to :user, index: true
			t.belongs_to :group, index: true
      t.timestamps null: false
    end
  end
end
