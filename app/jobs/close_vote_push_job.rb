class CloseVotePushJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
		push_id = args[0]
		restaurant_name = args[1]
		restaurant_id = args[2]
		vote_id = args[3]
		group_id = args[4]
	  APNS.host = 'gateway.sandbox.push.apple.com'
	  APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev.pem'
	  APNS.port = 2195
	  APNS.send_notification(push_id,
	                         :alert => "You and your friends are going to #{restaurant_name}",
	                         :sound => "owlsound.caf",
	                         :badge => +1,
	                         :other => { :push_type => "votedone",
	                                     :restaurant_id => restaurant_id,
	                                     :vote_id => vote_id,
	                                     :group_id => group_id
	                         }
	  )

		APNS.host = 'gateway.push.apple.com'
		APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev-deploy.pem'
		APNS.port = 2195
		APNS.send_notification(push_id,
		                       :alert => "You and your friends are going to #{restaurant_name}",
		                       :sound => "owlsound.caf",
		                       :badge => +1,
		                       :other => { :push_type => "votedone",
		                                   :restaurant_id => restaurant_id,
		                                   :vote_id => vote_id,
		                                   :group_id => group_id
		                       }
		)
  end
end
