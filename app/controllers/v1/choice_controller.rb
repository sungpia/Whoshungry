module V1
	class ChoiceController < ApplicationController
		before_action :get_user, :get_vote, except: [:make ]
		before_action :get_choice, except: [:create, :index]
		def create
			if Restaurant.exists?(place_id: params[:place_id])
				@restaurant = Restaurant.find_by(place_id: params[:place_id])
			else
				@restaurant = Restaurant.new
				@restaurant.place_id = params[:place_id]
				@restaurant.name = params[:name]
				@restaurant.picture = params[:picture]
				@restaurant.lat = params[:lat]
				@restaurant.lng = params[:lng]
				@restaurant.rating = params[:rating]
				@restaurant.save
			end

			#check duplication
			if Choice.exists?(vote: @vote, restaurant: @restaurant)
				render text: "Already existing restaurant in Vote", status: 409 and return
			else
				@vote.restaurants << @restaurant
			end
			@choice = Choice.find_by(vote_id: @vote.id, restaurant_id: @restaurant.id)
			render "v1/choice/create", status: 201
		end
		def index
			@choices = Choice.where(vote_id: @vote.id)
			render "v1/choice/index", status: 200
		end
		def show
			render "v1/choice/show", status: 200
		end

		def make
			#BAD METHOD, should take it off
			count = params[:count].to_i
			if Overlap.exists?(user: @user, choice: @choice)
				overlap = Overlap.find_by(user: @user, choice: @choice)
				if overlap.overlap + count < -1 || overlap.overlap + count > 1
					overlap.overlap = overlap.overlap + count
					overlap.save
					@choice.count = @choice.count + params[:count].to_i
					@choice.save
					VoteMadeJob.perform_now(@choice.vote.group)
				else
					render json: {error: "voting limit exceeded"}, status: 200
				end
			else
				overlap = Overlap.new
				overlap.overlap = overlap.overlap + count
				overlap.save
				@choice.count = @choice.count + params[:count].to_i
				@choice.save
				VoteMadeJob.perform_now(@choice.vote.group)
			end

			render "v1/choice/make", status: 200
		end
		def destroy
			@choice.destroy
			render status: 204
		end
		private
		def get_user
			begin
				@user = Auth.find_by(token: params[:token]).user
			rescue
				render json: {error: "not authorized user"}, status: 401
			end
		end
		def get_vote
			begin
				@vote = Vote.find(params[:vote_id])
			rescue
				render json: {error: "invalid vote id"}, status: 404
			end
		end
		def get_choice
			begin
				@choice = Choice.find(params[:choice_id])
			rescue
				render json: {error: "invalid choice id"}, status: 404
			end
		end
	end
end