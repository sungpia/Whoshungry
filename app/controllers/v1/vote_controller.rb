module V1
	class VoteController < ApplicationController
		before_action :get_group, :get_user
		before_action :get_vote, except: :create
		before_action :parse_restaurants, only: [:create, :update]

		def create
			puts @parsed
			@vote = Vote.new
			@vote.vote_type = @parsed["type"]
			@vote.name = @parsed["name"]
			@vote.expires_in = @parsed["expires_in"]
			@vote.expires_at = @parsed["expires_at"]
			@restaurants.each do |restaurant|
				@vote.restaurants << Restaurant.find_by(place_id: restaurant["place_id"])
			end
			@vote.save

			@group.votes << @vote

			#make push invitations to people
			InvitePeopleJob.perform_now(@group)
			#work queue for closing vote
			CloseVoteJob.set(wait: @vote.expires_in.minutes).perform_later(@group, @vote.id)
			#

			render "v1/vote/create", status: 201
		end

		def show
			render "v1/vote/show", status: 200
		end
		def destroy
			@vote.destroy
			render status: 204
		end
		def update

		end
		def add

		end

		private

		def get_group
			begin
				@group = Group.find(params[:group_id])
			rescue
				render text: "invalid group_id", status: 404
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
		def get_vote
			begin
				@vote = Vote.find(params[:id])
			rescue
				render text: "invalid vote", status: 404
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