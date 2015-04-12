module V1
	class LobbyController <ApplicationController

		before_action :get_user

		def index
			@lobbies = @user.votes.order(created_at: :desc).limit(params[:limit]).offset(params[:offset])

			render json: {lobbies: @lobbies}, status: 200
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
	end
end