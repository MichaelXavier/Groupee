Groupee::Application.routes.draw do |map|
  resources :assignments

  resources :agenda_items

  resources :courses

  resources :meetings

  resources :availabilities

  resources :group_memberships
  resources :groups
  resources :users do
    resources :group_memberships
  end

  #FIXME: this should redirect later to a sessions#new or something
  root :to => "groups#index"
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
