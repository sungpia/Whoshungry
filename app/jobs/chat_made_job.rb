class ChatMadeJob < ActiveJob::Base
  queue_as :default

  def perform(group, send_user, text)
    # Do something later
		group.users.each do |user|
			if user.id != send_user.id && user.registered == true
				user.devices.each do |device|
					ChatMadePushJob.perform_now(device.push_id, send_user.name, text)
				end
			end
		end
  end
end
