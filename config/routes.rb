require 'sidekiq/web'
Rails.application.routes.draw do

	mount Sidekiq::Web, at: "/sidekiq"
	namespace :v1 do
		#user
		match 'user', to: 'user#create', via: :post
		match 'user/:token/:id', to: 'user#show', via: :get
		match 'user/:token/:id', to: 'user#destroy', via: :delete
		match 'user/:token/:id', to: 'user#update', via: :update
		#session
		match 'login', to: 'user#login', via: :post
		#group
		match '/:token/group', to: 'group#create', via: :post
		match '/:token/group/:id', to: 'group#show', via: :get
		match '/:token/group/:id', to: 'group#update', via: :update
		match '/:token/group/:id', to: 'group#destroy', via: :delete
		#votes
		match '/:token/:group_id/vote', to: 'vote#create', via: :post
		match '/:token/:group_id/vote/:id', to: 'vote#show', via: :get
		#match '/:token/:group_id/vote/:id', to: 'vote#update', via: :update
		match '/:token/:group_id/vote/:id', to: 'vote#destroy', via: :delete
		#choice
		match '/:token/:vote_id/choices', to: 'choice#index', via: :get
		match '/:token/:vote_id/choices', to: 'choice#create', via: :post
		match '/:token/:vote_id/choice/:id', to: 'choice#show', via: :get
		#match '/:token/:vote_id/choice/:id', to: 'choice#update', via: :get
		match '/:token/:vote_id/choice/:id', to: 'choice#destroy', via: :delete
		match '/:token/:vote_id/choice/:id', to: 'choice#make', via: :post

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
