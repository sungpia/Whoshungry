class Group < ActiveRecord::Base
	has_many :votes
	has_many :crews
	has_many :users, through: :crews
end
