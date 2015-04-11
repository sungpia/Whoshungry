class InvitePeoplePushJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
		push_id = args[0]
		group_admin_name = args[1]
		group_id = args[2]
		vote_id = args[3]
	  APNS.host = 'gateway.sandbox.push.apple.com'
	  APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev.pem'
	  APNS.port = 2195
	  APNS.send_notification(push_id,
	                         :alert => "#{group_admin_name} Invited you!",
	                         :sound => "owlsound.caf",
	                         :badge => +1,
	                         :others => {
			                         :group_id => group_id,
	                             :vote_id => vote_id
	                         }
	  )

		APNS.host = 'gateway.push.apple.com'
		APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev-deploy.pem'
		APNS.port = 2195
		APNS.send_notification(push_id,
		                       :alert => "#{group_admin_name} Invited you!",
		                       :sound => "owlsound.caf",
		                       :badge => +1,
		                       :others => {
				                       :group_id => group_id,
				                       :vote_id => vote_id
		                       }
		)
  end
end
