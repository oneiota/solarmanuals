Solar::Application.routes.draw do

  devise_for :users
  
  resources :users, only: [:show, :update] do
    collection do 
      get :billing
      get :subscribe
      put :create_subscription
      put :unsubscribe
      get :edit_card
      put :update_card
      post :read_message
    end
  end

  resources :manuals do
    post :single_charge
    get :duplicate
    get :installer_signature
    get :contractor_signature
  end
  
  resources :invoices, :controller => "eway_payments", :only => [:show]
  
  resources :eway_payments, only: [:create]
  
  resources :images, only: [:destroy]
  resources :pdfs, only: [:destroy]
  
  put '/manuals/:id/document', to: 'manuals#document', as: "manual_document"
  
  put '/images/:id/set_feature', :to => 'images#set_feature', :as => 'set_feature'
  
  authenticated :user do
    root :to => "manuals#new"
  end
  
  get '/faq', to: 'home#faq'  
  get '/privacy', to: 'home#privacy'
  get '/delivery', to: 'home#delivery'
  get '/refunds', to: 'home#refunds'
  get '/terms', to: 'home#terms'
  
  root :to => 'home#index'

end
