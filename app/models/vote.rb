class Vote < ActiveRecord::Base
	has_many :chats
	has_many :users, through: :chats
	has_many :rsvps
	has_many :users, through: :rsvps
	belongs_to :group
end
