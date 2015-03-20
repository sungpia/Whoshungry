class User < ActiveRecord::Base
	has_many :subscriptions, foreign_key: :friends_to_id,
           dependent: :destroy
	has_many :friends_from, through: :subscriptions

	has_many :ratings
	has_many :restaurants, through: :ratings
	has_many :crews, dependent: :destroy
	has_many :groups, through: :crews
	has_many :rsvps, dependent: :destroy
	has_many :votes, through: :rsvps
	has_many :chats, dependent: :destroy
	has_many :votes, through: :chats
	has_many :choices, through: :votes
	has_many :locations, dependent: :destroy
	has_many :devices, dependent: :destroy
	has_one :auth, dependent: :destroy
	#some method like this..
	def be_friend(user)

	end
end
