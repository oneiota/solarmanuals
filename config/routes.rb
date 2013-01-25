Solar::Application.routes.draw do

  devise_for :users

  resources :manuals
  
  get '/manuals/:id/document', to: 'manuals#document', as: "manual_document"
  
  root :to => 'manuals#index'

end
