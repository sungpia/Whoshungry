module V1
	class UserController < ApplicationController
		before_action :get_user, except: [:create, :update]
		before_action :refine_contact, only: [:create]

		def create
			#Only creates if user is not registered to DB
			if User.exists?(contact: params[:contact]) == false or User.exists?(fb_id: params[:fb_id]) == false
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
			else #Else let user to use update
				@user = User.find_by(contact: params[:contact])
				if @user.registered == false
					@user.name = params[:name]
					@user.picture = params[:picture]
					@user.contact = params[:contact]
					@user.email = params[:email]
					@user.fb_id = params[:fb_id]
					@user.password = params[:access_token]
					@user.registered = true
					#create device and link to user
					if Device.exists?(push_id: params[:push_id]) == false
						device = Device.new
						device.os_type = params[:os_type]
						device.push_id = params[:push_id]
						device.save
						@user.devices << device
					end

					#create auth and link to user
					auth = Auth.new
					auth.login_type = "facebook"
					auth.save #auth will auto-generate token
					@user.auth = auth

					@user.save
					render "/v1/user/create",  status: 201
				else

					render json: {id: @user.id, error: "duplicate user : use update"}, status: 200
				end
			end
		end
		def update
			@user = User.find_by(contact: params[:contact])
			@user.name = params[:name]
			@user.picture = params[:picture]
			@user.contact = params[:contact]
			@user.email = params[:email]
			@user.fb_id = params[:fb_id]
			@user.password = params[:access_token]
			@user.registered = true
			#create device and link to user
			if Device.exists?(push_id: params[:push_id]) == false
				device = Device.new
				device.os_type = params[:os_type]
				device.push_id = params[:push_id]
				device.save
				@user.devices << device
			end

			#create auth and link to user
			auth = Auth.new
			auth.login_type = "facebook"
			auth.save #auth will auto-generate token
			@user.auth = auth

			@user.save
			render "/v1/user/create",  status: 201
		end
		def show
			render "/v1/user/show", status: 200
		end
		private
		def refine_contact
			if params[:contact].length == 10
				params[:contact] = "+1" + params[:contact]
			end
		end
		def get_user
			@user = User.find(params[:user_id])
			@devices = @user.devices
		end

	end
end

