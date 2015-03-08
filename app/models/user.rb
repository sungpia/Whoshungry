class User < ActiveRecord::Base
	has_many :subscriptions, foreign_key: :friends_to_id,
           dependent: :destroy
	has_many :friends_from, through: :subscriptions

	has_many :ratings
	has_many :restaurants, through: :ratings
	has_many :crews
	has_many :groups, through: :crews
	has_many :rsvps
	has_many :votes, through: :rsvps
	has_many :chats
	has_many :votes, through: :chats
	has_many :choices, through: :votes
	has_many :locations
	has_many :devices
	has_one :auth
	#some method like this..
	def be_friend(user)

	end
end
