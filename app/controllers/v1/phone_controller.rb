module V1
	class PhoneController < ApplicationController
		before_action :check_params
		def sendsms
			verification = Verification.new
			verification.contact = params[:contact]
			verification.save

			VerifyThroughTwilioJob.perform_now(verification.contact, verification.code)

			render json: {error: "SENT"}, status: 200
		end
		def verify
			verification = Verification.where(contact: params[:contact]).last
			text = ""
			if verification.code == params[:code]
				text = "OK"
				verification.destroy
			else
				text = "WRONG"
			end

			render json: {error: text}, status: 200
		end

		private

		def check_params
			if not params.has_key?(:contact)
				render json: {error: "No contact"}, status: 404
				false
			end
		end
	end
end