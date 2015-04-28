module V1
	class GroupController <ApplicationController
		before_action :get_user
		before_action :validate, only: [:create]
		def create
			#invitation = JSON.parse(request.raw_post)["invitation"]
			invitation = params[:invitation]
			@group = Group.new
			@group.user_id = @user.id
			@group.users << @user
			@group.save
				invitation.each do |invite|
					if invite.has_key?("fb_id")
						if User.exists?(fb_id: invite["fb_id"])
							user = User.find_by(fb_id: invite["fb_id"])
						else

						end
					elsif invite.has_key?("contact") #validating form
						if User.exists?(contact: invite["contact"]) #Does user exists with contact? else invite through Twilio
							user = User.find_by(contact: invite["contact"])
							if User.find_by(contact: invite["contact"]).registered == true #If not ghost user
								# user = User.find_by(contact: invite["contact"])
							else
								InviteThroughTwilioJob.perform_now(invite["contact"], @user.name)
							end
						else
							#creates possible user
							user = User.new
							user.contact = invite["contact"]
							user.save
							InviteThroughTwilioJob.perform_now(invite["contact"], @user.name)
						end
					end

					if @group.users.where(id: user.id)[0] == nil
						@group.users << user
					end

				end
				@group.save
			# rescue
			# 	render json: {error: "invalid format"}, status: 404 and return
			# 	false
			# end

			render "v1/group/create", status: 201
		end

		def show
			@group = Group.find(params[:group_id])
			render "v1/group/show", status: 200
		end

		def index
			@groups = @user.groups
			render json: {groups: @groups}, status: 200
		end
		def update
			invitation = JSON.parse(request.raw_post)["invitation"]
			@group.users.delete_all
			@group.user_id = @user.id
			@group.users << @user
			invitation.each do |invite|
				if invite.has_key?("id")
					user = User.find(invite["id"])
				elsif invite.has_key?("fb_id")
					user = User.find_by(fb_id: invite["fb_id"])
				end
				puts @group.users.exists?(id: user.id)
				if @group.users.exists?(id: user.id) != true
					@group.users.each do |x|
						puts x.id
					end
					puts "above : already on group"
					puts user.id
					@group.users << user
				end
			end
			@group.save
			render "v1/group/update", status: 200
		end
		def destroy
			if @group.user_id == @user.id
				@group.users.delete_all
				@group.destroy
				render status: 204
			else
				render json: {error: "no right"}, status: 401
			end

		end

		private
		def get_user
			if Auth.exists?(token: params[:token])
				@user = Auth.find_by(token: params[:token]).user
			else
				render json: {error: "not authorized user"}, status: 401
				false
			end
		end

		def validate
			puts "validating"
			#invitation = JSON.parse(request.raw_post)["invitation"]
			invitation = params[:invitation]
			begin
				invitation.each do |invite|
					puts invite
					if invite.has_key?("fb_id")
						next
					elsif invite.has_key?("contact")
						puts "yes1"
						if User.exists?(contact: invite["contact"])
							puts "yes2"
							if User.find_by(contact: invite["contact"]).registered == true
								puts "yes3"
								user = User.find_by(contact: invite["contact"])
								puts user
							else
								#creates possible user
								#render json: {error: "invalid format 1"}, status: 404
								#false
							end
						end
					end
				end
					puts "ok"
			rescue
				puts "wrong"
				render json: {error: "invalid format 2"}, status: 404
				false
			end
		end
	end
end