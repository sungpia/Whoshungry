module V1
	class RsvpController < ApplicationController
		before_action :get_user, :get_vote

		def create
			@rsvp = Rsvp.new(user: @user, vote: @vote, rsvp: params[:rsvp])
			@rsvp.save
			@vote.rsvps << @rsvp
			RsvpMadeJob.perform_now(@user.group)
			render 'v1/rsvp/create', status: 201
		end
		def index
			render 'v1/rsvp/index', status: 200
		end
		private
		def get_user
			if Auth.exists?(token: params[:token])
				@user = Auth.find_by(token: params[:token]).user
			else
				render json: {error: "Unauthorized User"}, status: 401
			end
		end
		def get_vote
			if Vote.exists?(params[:vote_id])
				@vote = Vote.find(params[:vote_id])
			else
				render json: {error: "Invalid vote_id"}, status: 404
			end
		end
	end
end