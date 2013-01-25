Solar::Application.routes.draw do

  devise_for :users

  resources :manuals
  
  get '/manuals/:id/document', to: 'manuals#document', as: "manual_document"
  
  authenticated :user do
    root :to => "manuals#index"
  end
  
  root :to => 'home#index'

end
