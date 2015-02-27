class Subscription < ActiveRecord::Base
	belongs_to :friends_from
	belongs_to :friends_to

end
