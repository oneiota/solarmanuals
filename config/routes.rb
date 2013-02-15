Solar::Application.routes.draw do

  devise_for :users
  
  resources :users, only: [:show, :update] do
    put :subscribe
    put :unsubscribe
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
  
  root :to => 'home#index'

end
