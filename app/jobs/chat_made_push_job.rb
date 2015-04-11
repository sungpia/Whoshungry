class ChatMadePushJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
		push_id = args[0]
		sender_name = args[1]
		message = args[2]
		message = message.truncate(30)
	  APNS.host = 'gateway.sandbox.push.apple.com'
	  APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev.pem'
	  APNS.port = 2195
	  APNS.send_notification(push_id,
	                         :alert => "#{sender_name} : #{message}",
	                         :sound => "owlsound.caf",
	                         :badge => +1
	  )

	  APNS.host = 'gateway.push.apple.com'
	  APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev-deploy.pem'
	  APNS.port = 2195
	  APNS.send_notification(push_id,
	                         :alert => "#{sender_name} : #{message}",
	                         :sound => "owlsound.caf",
	                         :badge => +1,
	  )
  end
end
