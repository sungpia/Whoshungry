require 'sidekiq/web'
Rails.application.routes.draw do

	mount Sidekiq::Web, at: "/sidekiq"
	match '/', to: 'health#index', via: :get
	namespace :v1 do
		#user
		match 'users', to: 'user#create', via: :post
		match ':token/user/:user_id', to: 'user#show', via: :get
		match 'users', to: 'user#update', via: :put
		# match 'user/:token/:id', to: 'user#destroy', via: :delete
		# match 'user/:token/:id', to: 'user#update', via: :update
		#auth
		match 'auth', to: 'auth#login', via: :post
		#group
		match '/:token/groups', to: 'group#create', via: :post
		match '/:token/groups', to: 'group#index', via: :get
		match '/:token/group/:group_id', to: 'group#show', via: :get
		# match via :get
		# match '/:token/group/:id', to: 'group#update', via: :update
		# match '/:token/group/:id', to: 'group#destroy', via: :delete
		#votes
		match '/:token/:group_id/votes', to: 'vote#create', via: :post
		match '/:token/vote/:vote_id', to: 'vote#show', via: :get
		# match '/:token/:group_id/vote/:id', to: 'vote#update', via: :update
		# match '/:token/:group_id/vote/:id', to: 'vote#destroy', via: :delete
		#choice
		match '/:token/:vote_id/choices', to: 'choice#index', via: :get
		match '/:token/:vote_id/choices', to: 'choice#create', via: :post
		match '/:token/choice/:choice_id', to: 'choice#make', via: :put
		#match '/:token/:vote_id/choice/:id', to: 'choice#update', via: :get
		# match '/:token/:vote_id/choice/:id', to: 'choice#destroy', via: :delete
		# match '/:token/:vote_id/choice/:id', to: 'choice#make', via: :update

		#rsvp
		match '/:token/:vote_id/rsvps', to: 'rsvp#create', via: :post
		match '/:token/:vote_id/rsvps', to: 'rsvp#index', via: :get

		#location
		match '/:token/locations', to: 'location#create', via: :post
		match '/:token/:vote_id/locations', to: 'location#index', via: :get
		#restaurant
		match '/:token/restaurant/:restaurant_id', to: 'restaurant#show', via: :get

		#lobby
		match '/:token/lobbies', to: 'lobby#index', via: :post

		#Verification
		match 'phone/verify', to: 'phone#verify', via: :post
		match 'phone/sendsms', to: 'phone#sendsms', via: :post

		#Chat
		match ':token/:vote_id/chat', to: 'chat#create', via: :post
		match ':token/:vote_id/chat', to: 'chat#index', via: :get
	end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
