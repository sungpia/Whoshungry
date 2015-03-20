class CloseVotePushJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
	  APNS.host = 'gateway.sandbox.push.apple.com'
	  APNS.pem = '/Users/sungpi/RubymineProjects/Whoshungry/app/assets/apns-dev.pem'
	  APNS.port = 2195
	  APNS.send_notification(args[0], :alert => "FUCK YOU ALEJANDRO", :sound => "owlsound.caf", :badge => +1)
  end
end
