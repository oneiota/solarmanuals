Solar::Application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :update]

  resources :manuals
  
  resources :payments, only: [:show, :create, :destroy, :update] do
    collection do
      get :success
      get :cancel
      post :notify
    end
  end
  
  get '/manuals/:id/document', to: 'manuals#document', as: "manual_document"
  
  authenticated :user do
    root :to => "manuals#index"
  end
  
  root :to => 'home#index'

end
