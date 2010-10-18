ActionController::Routing::Routes.draw do |map|
  map.resources :rezlineitems

  map.resources :ticketsections

  map.resources :ticketrezs

  map.resources :ticketalerts

  map.resources :users
  
  map.resources :updates

  map.resources :shows

  map.resources :contents

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  map.connect 'about/', :controller => "index", :action => "showpane", :id => "about"
  map.connect '70ai/', :controller => "index", :action => "showpane", :id => "70ai"
  map.connect 'news/', :controller => "index", :action => "news"
  
  map.connect 'boxoffice/', :controller => "boxoffice"
  map.connect 'boxoffice/:abbrev', :controller => "boxoffice", :action => "show"
  
  map.connect 'admin/forgot/:hashed_password', :controller => "admin", :action => "forgot"
  
  map.connect 'tickets/show/:abbrev', :controller => "tickets", :action => "show"
  map.connect 'tickets/unsubscribe/:hashid', :controller => "tickets", :action => "removeticketalert"
  map.connect 'tickets/cancel/:hashid',:controller => "tickets", :action => "cancelrez"
  
  map.connect 'ticketsections/new/:abbrev', :controller => "ticketsections", :action => "new"
  map.connect 'ticketalerts/new/:abbrev', :controller => "ticketalerts", :action => "new"
  map.connect 'ticketrezs/new/:abbrev', :controller => "ticketrezs", :action => "new"
  
  map.connect 'rezlineitems/new/:ticketrezid', :controller => "rezlineitems", :action => "new"

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
