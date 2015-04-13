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
	has_many :choices, through: :votes
	has_many :locations, dependent: :destroy
	has_many :devices, dependent: :destroy
	has_one :auth, dependent: :destroy
	has_many :overlaps
	#some method like this..
	before_save :refine_contact

	def refine_contact
		if self.contact.length == 10
			self.contact = "+1" + self.contact
		end
	end
	def be_friend(user)

	end
end
