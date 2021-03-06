class VoteMadeJob < ActiveJob::Base
  queue_as :default

  def perform(group)
		group.users.each do |user|
			if user.registered == true
				user.devices.each do |device|
					VoteMadePushJob.perform_now(device.push_id)
				end
			end
		end
  end
end
