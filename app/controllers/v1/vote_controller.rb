module V1
	class VoteController < ApplicationController
		before_action :get_group, :get_user
		before_action :parse_restaurants, only: [:create]

		def create
			puts @parsed
			vote = Vote.new
			vote.vote_type = @parsed["type"]
			vote.name = @parsed["name"]
			vote.expires_in = @parsed["expires_in"]
			vote.expires_at = @parsed["expires_at"]
			@restaurants.each do |restaurant|
				puts restaurant
				puts Restaurant.find_by(place_id: restaurant["place_id"])
				vote.restaurants << Restaurant.find_by(place_id: restaurant["place_id"])
			end
			vote.save

			@group.votes << vote

			rest = []
			Choice.where(vote_id: vote.id).each do |choice|
				puts Restaurant.find(choice.restaurant_id).id
			end

			render json: [vote]
		end

		def show
			vote = Vote.find(params[:id])
			puts vote.restaurants
		end
		private

		def get_group
			begin
				@group = Group.find(params[:group_id])
			rescue
				render text: "invalid group_id", status: 400
			end
		end
		def get_user
			begin
				@user = Auth.find_by(token: params[:token]).user
			rescue
				render text: "not authorized user", status: 401
				return false
			end
		end

		def parse_restaurants
			begin
				@parsed = JSON.parse(request.raw_post)
				@restaurants = @parsed["restaurants"]
				@restaurants.each do |restaurant|
					if Restaurant.exists?(place_id: restaurant["place_id"])
					else
						new_restaurant = Restaurant.new
						new_restaurant.place_id = restaurant["place_id"]
						new_restaurant.name = restaurant["name"]
						new_restaurant.picture = restaurant["picture"]
						new_restaurant.lat = restaurant["lat"]
						new_restaurant.lng = restaurant["lng"]
						new_restaurant.rating = restaurant["rating"]
						new_restaurant.save

					end
				end
			rescue
				render text: "invalid restaurant form", status: 400
				return false
			end

		end
	end
end