module V1
	class UserController < ApplicationController
		before_action :get_user, except: :create
		before_action :refine_contact

		def create
			#Only creates if user is not registered to DB
			if User.exists?(contact: params[:contact]) == false
				#create user
				@user = User.new
				@user.name = params[:name]
				@user.picture = params[:picture]
				@user.contact = params[:contact]
				@user.email = params[:email]
				@user.fb_id = params[:fb_id]
				@user.password = params[:access_token]
				@user.registered = true
				#create device and link to user
				device = Device.new
				device.os_type = params[:os_type]
				device.push_id = params[:push_id]
				device.save
				@user.devices << device
				#create auth and link to user
				auth = Auth.new
				auth.login_type = "facebook"
				auth.save #auth will auto-generate token
				@user.auth = auth

				@user.save
				render "/v1/user/create", status: 201
			elsif User.exists?(contact: params[:contact]) == true && User.registered == false
				@user = User.find_by(contact: params[:contact])
				@user = User.new
				@user.name = params[:name]
				@user.picture = params[:picture]
				@user.contact = params[:contact]
				@user.email = params[:email]
				@user.fb_id = params[:fb_id]
				@user.password = params[:access_token]
				@user.registered = true
				#create device and link to user
				device = Device.new
				device.os_type = params[:os_type]
				device.push_id = params[:push_id]
				device.save
				@user.devices << device
				#create auth and link to user
				auth = Auth.new
				auth.login_type = "facebook"
				auth.save #auth will auto-generate token
				@user.auth = auth

				@user.save
				render "/v1/user/create",  status: 201
			else #Else let user to use update
				render json: {error: "duplicate user : use update"}, status: 409
			end
		end

		private
		def refine_contact
			if params[:contact].length == 10
				params[:contact] = "+1" + params[:contact]
			end
		end
		def get_user
			@user = User.find(params[:id])
			@devices = @user.devices
		end

	end
end

