module V1
	class VoteController < ApplicationController
		before_action :get_group, except: [:index, :show]
		before_action :get_user
		before_action :get_vote, except: [:create, :index]
		before_action :parse_restaurants, only: [:create, :update]

		def create

			@vote = Vote.new
			@vote.vote_type = params[:type]
			@vote.name = params[:name]
			@vote.expires_in = params[:expires_in]
			@vote.expires_at = params[:expires_at]
			@restaurants.each do |restaurant|
				@vote.restaurants << Restaurant.find_by(place_id: restaurant["place_id"])
			end
			@vote.save
			@group.votes << @vote

			@vote.group.users.each do |user|
				rsvp = Rsvp.new(user: user, vote: @vote, rsvp: 1)
				rsvp.save
			end

			#make push invitations to people
			InvitePeopleJob.perform_now(@group,@vote.id)
			#work queue for closing vote
			CloseVoteJob.set(wait: @vote.expires_in.minutes).perform_later(@group, @vote.id)
			#

			render "v1/vote/create", status: 201
		end
		def index

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
				render json: {error: "invalid group_id"}, status: 404
			end
		end
		def get_user
			begin
				@user = Auth.find_by(token: params[:token]).user
			rescue
				render json: {error: "not authorized user"}, status: 401
				return false
			end
		end
		def get_vote
			begin
				@vote = Vote.find(params[:vote_id])
			rescue
				render json: {error: "invalid vote"}, status: 404
			end
		end
		def parse_restaurants
			begin
				# @parsed = JSON.parse(request.raw_post)
				# @restaurants = @parsed["restaurants"]
				@restaurants = params[:restaurant]
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
				render json: {error: "invalid restaurant form"}, status: 400
				return false
			end

		end
	end
end