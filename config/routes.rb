Gin::Application.routes.draw do
  resources :rezlineitems
  resources :ticketsections
  resources :ticketrezs
  resources :users
  resources :updates
  resources :shows
  resources :contents
  match '/about/' => 'index#showpane', :id => 'about'
  match '/initiative/' => 'index#showpane', :id => '70ai'
  match '/news/' => 'index#news'
  match '/boxoffice/' => 'boxoffice#index'
  match '/boxoffice/:abbrev' => 'boxoffice#show'
  match '/admin/forgot/:hashed_password' => 'admin#forgot'
  match '/tickets/show/:abbrev' => 'tickets#show'
  match '/tickets/unsubscribe/:hashid' => 'tickets#removeticketalert'
  match '/tickets/cancel/:hashid' => 'tickets#cancelrez'
  match '/ticketsections/new/:abbrev' => 'ticketsections#new'
  match '/ticketrezs/new/:abbrev' => 'ticketrezs#new'
  match '/ticketrezs/:id/sendemail' => 'tickets#sendemail'
  match '/rezlineitems/new/:ticketrezid' => 'rezlineitems#new'
  root :to => 'index#index'
  match '/:controller(/:action(/:id))'
end