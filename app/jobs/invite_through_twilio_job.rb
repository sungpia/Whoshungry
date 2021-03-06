require 'twilio-ruby'
class InviteThroughTwilioJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    contact = args[0]
    invite_message = args[1] + " Invited you out to eat! Download \"Who's Hungry?\" at http://apple.co/1ATmuD8"
# put your own credentials here
	  account_sid = 'AC4f3f27e9fe0992c071939c49ab56ad0f'
	  auth_token = 'da4f7a3447e308a033410657612653ff'

	  if contact.length == 10
			contact = "+1" + contact
	  end
	  puts contact
	  puts invite_message

# set up a client to talk to the Twilio REST API
	  @client = Twilio::REST::Client.new account_sid, auth_token

	  message = @client.account.messages.create({
			                                            :from => '+15129911407',
			                                            :to => contact,
			                                            :body => invite_message,
	                                            })

	  puts message.to

  end
end
