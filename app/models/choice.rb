class Choice < ActiveRecord::Base
	belongs_to :restaurant
	belongs_to :vote
	has_many :overlaps
end
