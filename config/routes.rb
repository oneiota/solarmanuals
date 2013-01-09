Solar::Application.routes.draw do
  resources :manuals
  
  get '/manuals/:id/document', to: 'manuals#document', as: "manual_document"
  
  root :to => 'manuals#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
