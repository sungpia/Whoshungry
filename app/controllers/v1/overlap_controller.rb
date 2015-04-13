module V1
	class OverlapController < ApplicationController
		before_action :get_user
		def show
			@overlap = Overlap.find_by(user: @user, choice: @choice)
			render json: @overlap, status: 200
		end

		private
		def get_user
			if Auth.exists?(token: params[:token])
				@user = Auth.find_by(token: params[:token]).user
			else
				render json: {error: "Unauthorized User"}, status: 401
			end
		end
		def get_choice
			if Choice.exists?(params[:choice_id])
				@choice = Choice.find(params[:choice_id])
			else
				render json: {error: "Invalid choice_id"}, status: 404
			end
		end
	end
end