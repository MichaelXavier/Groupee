Groupee::Application.routes.draw do |map|
  devise_for :users


  resources :agenda_items

  resources :courses do
    put :enroll, :on => :member
    put :remove_student, :on => :member

    resources :assignments
  end

  resources :meetings do
    resources :agenda_items
  end

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
