class CloseVoteJob < ActiveJob::Base
  queue_as :default

  def perform(group, vote_id)
		vote = Vote.find(vote_id)
		choices = vote.choices
		winner = choices.order(count: :desc).first
		vote.restaurant_id= winner.restaurant_id
		vote.save
		restaurant = Restaurant.find(winner.restaurant_id)
	  group.users.each do |user|
		  puts user
		  user.devices.each do |device|
			  puts device.push_id
			  CloseVotePushJob.perform_now(device.push_id,
			                               restaurant.name,
			                               restaurant.id,
			                               vote.id,
			                               group.id
			  )
		  end
	  end
  end
end
