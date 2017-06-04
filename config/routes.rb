Rails.application.routes.draw do
  root "shops#index"
  resources :systems do
    collection do
      get "buy"
      # post "buy"
      get "scan"
      get "input_money"
      post "get_money"
      post "csv_export"
      post "csv_export_buy"
    end
  end
  resources :rules
  resources :faqs
  resources :inquiries
  resources :messages do
    collection do
      get "user_select"
    end
  end
  resources :news do
    collection do
      post "create"
      post "update"
    end
  end
  resources :coupons do
    collection do
      post "update"
    end
  end
  resources :menus do
    collection do
      get "shop_select"
      post "ajax"
      post "update"
    end
  end
  resources :categories do
    collection do
      delete "destroy"
      post 'create'
    end
  end
  resources :shops do
    collection do
      post "image_preview"
      post "pre"
      patch "pre"
      get "edit"
      post "create"
      post "update"
    end
  end
  resources :users
  resources :admins do
    collection do
      get "login"
      post "login"
      get "logout"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match 'shops/index',:to => 'shops#index',:via => [:post]
  match 'categories/index',:to => 'categories#index',:via => [:post]
  match 'menus/index',:to => 'menus#index',:via => [:post]
  match 'menus/shop_select',:to => 'menus#shop_select',:via => [:post]
  match 'coupons/index',:to => 'coupons#index',:via => [:post]
  match 'users/index',:to => 'users#index',:via => [:post]
  match 'admins/index',:to => 'admins#index',:via => [:post]
  match 'news/index', :to => 'news#index', :via => [:post]
  match 'messages/index', :to => 'messages#index', :via => [:post]
  match 'inquiries/index', :to => 'inquiries#index', :via => [:post]
  match 'systems/index', :to => 'systems#index', :via => [:post]
  match 'systems/buy', :to => 'systems#buy', :via => [:post]
end
