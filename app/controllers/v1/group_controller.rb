module V1
	class GroupController <ApplicationController
		before_action :get_user, :parse_invitation

		def create
			invitation = JSON.parse(request.raw_post)["invitation"]
			group = Group.new
			group.user_id = @user.id
			group.users << @user

			invitation.each do |invite|
				if invite.has_key?("id")
					user = User.find(invite["id"])
				elsif invite.has_key?("fb_id")
					user = User.find_by(fb_id: invite["fb_id"])
				end
				if not group.users.exists?(id: user.id)
					puts "why"
					group.users << user
				end
			end
			group.save

			render json: [group, group.users]
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