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
  
  resources :images, only: [:destroy]
  resources :pdfs, only: [:destroy]
  
  get '/manuals/:id/document', to: 'manuals#document', as: "manual_document"
  
  put '/images/:id/set_feature', :to => 'images#set_feature', :as => 'set_feature'
  
  authenticated :user do
    root :to => "manuals#index"
  end
  
  get '/faq', to: 'home#faq'  
  get '/privacy', to: 'home#privacy'
  get '/delivery', to: 'home#delivery'
  get '/refunds', to: 'home#refunds'
  get '/terms', to: 'home#terms'
  
  root :to => 'home#index'

end
