class InvitePeopleJob < ActiveJob::Base
  queue_as :default

  def perform(group, vote_id)
		admin_user_name = User.find(group.user_id).name
		group.users.each do |user|
			if group.user_id != user.id
				puts user
				user.devices.each do |device|
					puts device.push_id
					InvitePeoplePushJob.perform_now(device.push_id,
					                                admin_user_name,
					                                group.id,
					                                vote_id
					)
				end
			end
		end
  end
end
