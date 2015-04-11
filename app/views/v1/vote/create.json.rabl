object @vote
attributes :id, :group_id, :vote_type, :name, :expires_in, :expires_at, :created_at, :updated_at, :choices
child :choices do
	attributes :id, :vote_id, :restaurant_id, :count, :created_at, :updated_at
end