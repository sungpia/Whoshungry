module V1
	class AuthController < ApplicationController
		before_action :get_user

		def login
			#check
			puts "User password : ", @user.password
			puts "Access token : ", params[:access_token]
			if @user.password == params[:access_token]
				@auth = Auth.find_by(user: @user)
				render 'v1/auth/login', status: 200
			else
				render json: {error: "not valid access_token : check your documentation"}, status: 401
			end
		end

		private
		# Get user
		def get_user
			puts params[:user_id]
			if User.exists?(id: params[:user_id]) == true
				@user = User.find(params[:user_id])
				puts @user
			else
				render json: {error: "not existing user_id : check your documentation"}, status: 400
				false
			end
		end
	end
end