module V1
	class ChatController < ApplicationController
		before_action :get_user, :get_vote

		def index
			render json: @vote.chats, status: 200
		end
		def create
			@chat = Chat.new
			@chat.user = @user
			@chat.vote = @vote
			@chat.chat = params[:text]
			@chat.save
			puts @vote.group.id
			ChatMadeJob.perform_now(@vote.group, @user, @chat.chat)
			render json: @chat, status: 201
		end

		private
		def get_user
			begin
				@user = Auth.find_by(token: params[:token]).user
			rescue
				render json: {error: "not authorized user"}, status: 401
			end
		end
		def get_vote
			begin
				@vote = Vote.find(params[:vote_id])
			rescue
				render json: {error: "invalid vote id"}, status: 404
			end
		end
	end
end