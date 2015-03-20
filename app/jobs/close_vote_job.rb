class CloseVoteJob < ActiveJob::Base
  queue_as :default

  def perform(group, vote_id)
		vote = Vote.find(vote_id)
		choices = vote.choices
		winner = choices.order(count: :desc).first
		vote.restaurant_id= winner.restaurant_id
		vote.save
		puts "WORK DONE"
		puts winner
		puts winner.restaurant_id
		puts vote

	  group.users.each do |user|
		  puts user
		  user.devices.each do |device|
			  puts device.push_id
			  CloseVotePushJob.perform_now(device.push_id, "hey", "")
		  end
	  end
  end
end
