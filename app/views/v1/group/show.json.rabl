object @group
attributes :id, :user_id, :created_at, :updated_at, :users, :created_at, :updated_at
child :users do
	attributes :id, :fb_id,  :name, :picture, :contact, :email, :created_at, :updated_at, :devices
end