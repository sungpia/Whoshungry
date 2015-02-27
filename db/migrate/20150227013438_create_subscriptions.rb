class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
			t.belongs_to :friends_from, class_name: 'User'
			t.belongs_to :friends_to, class_name: 'User'
      t.timestamps null: false
    end
  end
end
