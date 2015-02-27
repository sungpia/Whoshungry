class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
			t.belongs_to :user
			t.belongs_to :group
      t.timestamps null: false
    end
		add_index(:crews, :user_id)
		add_index(:crews, :group_id)
  end
end
