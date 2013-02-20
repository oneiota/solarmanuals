Solar::Application.routes.draw do

  devise_for :users
  
  resources :users, only: [:show, :update] do
    collection do
      put :subscribe
      put :unsubscribe
      get :edit_card
      put :update_card
    end
  end

  resources :manuals do
    post :pay
  end
  
  resources :invoices, :controller => "eway_payments", :only => [:show]
  
  resources :eway_payments, only: [:create]
  
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
