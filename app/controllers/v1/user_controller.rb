module V1
	class UserController < ApplicationController
		before_action :get_user, except: :create
		before_action :verify_user, except: [:create, :facebook_login, :login]

		def facebook_login
			auth = Auth.new
			auth.login_type = "facebook"
			auth.token = params[:access_token]
			auth.save

			@user.auth = auth
			@user.save

			render json: auth, status: 200
		end
		def login
			if @user.password == params[:password]
				auth = Auth.new
				auth.login_type = "default"
				auth.save
				@user.auth = auth
				@user.save

				render json: auth, status: 200

			else
				render text: "login fail: wrong id or pw", status: 401
			end
		end
		def logout

		end
		def create
			if User.where(contact: params[:contact])[0] == nil
				@user = User.new
				@user.name = params[:name]
				@user.picture = params[:picture]
				@user.contact = params[:contact]
				@user.email = params[:email]
				@user.fb_id = params[:fb_id]
				@user.password = params[:password]

				device = Device.new
				device.os_type = params[:os_type]
				device.push_id = params[:push_id]
				device.save

				@user.devices << device
				@user.save

				render "/v1/user/create", status: 201
			else
				render text: "duplicate user : use update", status: 409
			end
		end

		def show
			render "/v1/user/show", status: 200
		end

		def update
			render "/v1/user/update", status: 200
		end

		def destroy
			@user.destroy
			render status: 204
		end

		private
		def get_user
			@user = User.find(params[:id])
			@devices = @user.devices
		end

		def verify_user
			if params[:token] == @user.auth.token
				return true
			else
				return false
			end
		end

	end
end

