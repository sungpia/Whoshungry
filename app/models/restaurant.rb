class Restaurant < ActiveRecord::Base
	has_many :ratings
	has_many :users, through: :ratings
	has_many :choices
	has_many :votes, through: :choices
end
