class RsvpMadeJob < ActiveJob::Base
  queue_as :default

  def perform(group)
		group.users.each do |user|
			user.devices.each do |device|
				RsvpMadePushJob.perform_now(device.push_id)
			end
		end
  end
end
