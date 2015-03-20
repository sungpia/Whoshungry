class Vote < ActiveRecord::Base
	has_many :chats, dependent: :destroy
	has_many :users, through: :chats
	has_many :rsvps, dependent: :destroy
	has_many :users, through: :rsvps
	has_many :choices, dependent: :destroy
	has_many :restaurants, through: :choices
belongs_to :group, dependent: :destroy
end
