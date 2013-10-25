Beavertracks::Application.routes.draw do

  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'beavertracks#index'

  resources :buildings
  get 'buildings/:id' => 'buildings#show'
  get 'buildings/:id/image' => 'buildings#image'
  get 'buildings/:id/:flickr_photo_id' => 'buildings#flickr_view'

  get 'beavertracks' => 'beavertracks#index'
  get 'beavertracks/about', as: 'about_beavertracks'
  get 'beavertracks/instructions', as: 'instructions_beavertracks'

  resources :maps do
    member do 
      get 'directions'
      get 'locations'
      get 'tour'
    end
  end

  resources :patrons


 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
