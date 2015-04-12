module V1
	class PhoneController < ApplicationController
		before_action :check_params
		def sendsms
			verification = Verification.new
			verification.contact = params[:contact]
			verification.save

			VerifyThroughTwilioJob.perform_now(verification.contact, verification.code)

			render json: {message: "SENT"}, status: 200
		end
		def verify
			verification = Verification.find_by(contact: params[:contact]).last
			text = ""
			if verification.code == params[:code]
				text = "OK"
			else
				text = "WRONG"
			end

			render json: {message: text}, status: 200
		end

		private

		def check_params
			if not params.has_key?(:contact)
				render json: {message: "No contact"}, status: 404
				false
			end
		end
	end
end