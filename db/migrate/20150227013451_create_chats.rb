class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
			t.belongs_to :user, index: true, null: false
			t.belongs_to :vote, index: true, null: false
			t.text :chat
      t.timestamps null: false
    end
  end
end
