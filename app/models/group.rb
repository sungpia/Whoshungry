class Group < ActiveRecord::Base
	has_many :votes, dependent: :destroy
	has_many :crews, dependent: :destroy
	has_many :users, through: :crews

end
