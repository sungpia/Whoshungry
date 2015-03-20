module V1
	class GroupController <ApplicationController
		before_action :get_user
		before_action :get_group, except: :create
		before_action :parse_invitation

		def create
			invitation = JSON.parse(request.raw_post)["invitation"]
			@group = Group.new
			@group.user_id = @user.id
			@group.users << @user
			@group.save
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

			render "v1/group/create", status: 201
		end
		def show
			render "v1/group/show", status: 200
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
				render text: "no right", status: 401
			end

		end
		private
		def get_user
			begin
				@user = Auth.find_by(token: params[:token]).user
			rescue
				render text: "not authorized user", status: 401
				return false
			end
		end
		def get_group
			begin
				@group = Group.find(params[:id])
			rescue
				render text: "not existing group", status: 404
				return false
			end
		end

		def parse_invitation
			@invitation = JSON.parse(request.raw_post)["invitation"]
			begin
				@invitation.each do |invite|
					if invite.has_key?("id")
						user = User.find(invite["id"])
					elsif invite.has_key?("fb_id")
						user = User.find_by(fb_id: invite["fb_id"])
					end
				end
			rescue
				render text: "invalid format"
				return false
			end
		end

	end
end