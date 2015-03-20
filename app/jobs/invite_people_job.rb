class InvitePeopleJob < ActiveJob::Base
  queue_as :default

  def perform(group)

		puts "WTF is group? "
		puts group
		group.users.each do |user|
			puts user
			user.devices.each do |device|
				puts device.push_id
				InvitePeoplePushJob.perform_now(device.push_id, "hey", "")
			end
		end
  end
end
