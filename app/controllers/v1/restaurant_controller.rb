module V1
	class RestaurantController < ApplicationController
		before_action :get_user
		def show
			if Restaurant.exists?(id: params[:restaurant_id])
				@restaurant = Restaurant.find(params[:restaurant_id])
			elsif Restaurant.exists?(place_id: params[:restaurant_id])
				@restaurant = Restaurant.find_by(place_id: params[:restaurant_id])
			else
				render json: {error: "invalid restaurant id"}, status: 401 and return
			end

			render 'v1/restaurant/show', status: 200
		end
		private
		def get_user
			if Auth.exists?(token: params[:token])
				@user = Auth.find_by(token: params[:token]).user
			else
				render json: {error: "unauthorized token"}, status: 401
			end
		end
	end
end