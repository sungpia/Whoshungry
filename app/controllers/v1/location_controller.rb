module V1
	class LocationController < ApplicationController
		before_action :get_user
		def create
			@location = Location.new(user: @user, lat: params[:lat], lng: params[:lng], pickup: params[:pickup])
			@location.save
			render 'v1/location/create', status: 201
		end
		def index
			vote = Vote.find(params[:vote_id])
			users = vote.group.users
			@locations = {}
			@locations["locations"] = []
			@locations["user_id"]
			users.each do |x|
				@locations["locations"] << x.locations.last
			end
			render json: @locations, status: 200
		end

		private
		def get_user
			if Auth.exists?(token: params[:token])
				@user = Auth.find_by(token: params[:token]).user
			else
				render json: {error: "invalid token"}, status: 401
			end
		end
	end
end