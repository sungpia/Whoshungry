module V1
	class ChoiceController < ApplicationController
		before_action :get_user, :get_vote
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

			@vote.restaurants << @restaurant
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
			@choice.count = @choice.count + params[:count].to_i
			@choice.save
			render "v1/choice/make", status: 201
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
				render text: "not authorized user", status: 401
			end
		end
		def get_vote
			begin
				@vote = Vote.find(params[:vote_id])
			rescue
				render text: "invalid vote id", status: 404
			end
		end
		def get_choice
			begin
				@choice = Choice.find(params[:id])
			rescue
				render text: "invalid choice id", status: 404
			end
		end
	end
end