Rails.application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'

  resources :pages, only: [:show]
  resources :cafes, :art_galleries, only: [:index, :show]

  resources :emerging_artists, path: 'emerging-artists', only: [:index, :show]
  resources :art_galleries, path: 'art-galleries', only: [:index, :show]

  resources :articles, path: 'news', only: [:index, :show]
  get '/news/category/:tag' => 'articles#index', as: 'news_tags'

  resources :events
  get '/events/category/:tag' => 'events#index', as: 'events_tags'
  get '/calendar' => 'events#calendar', as: 'calendar'

  # ===============
  # ADMIN Namespace
  # ===============
  concern :has_assets do
    resources :assets, only: [:index, :create, :destroy]
  end

  concern :has_pictures do
    resources :pictures, controller: :assets, only: [:index, :create, :destroy], concerns: :has_assets
  end

  concern :has_cover_photo do
    resources :cover_photo, controller: :assets, only: [:create, :destroy]
  end

  namespace :admin do
    resources :pages, :cafes, :events, concerns: [:has_assets, :has_pictures, :has_cover_photo]
    resources :emerging_artists, path: 'emerging-artists', concerns: [:has_assets, :has_pictures, :has_cover_photo]
    resources :art_galleries, path: 'art-galleries', concerns: [:has_assets, :has_pictures, :has_cover_photo]
    resources :articles, path: 'news', concerns: [:has_assets, :has_pictures, :has_cover_photo]
    resources :galleries, concerns: [:has_pictures, :has_assets]
    resources :profiles, concerns: [:has_assets] do
      resources :profile_photo, controller: :assets, only: [:create, :destroy]
    end
    #
    resources :users
    #
    root to: 'pages#index'
  end

  root to: 'pages#home'

  # devise_for :users, :skip => [:sessions]
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :signin
    delete 'signout' => 'devise/sessions#destroy', :as => :signout
  end

  # Catch all error
  match "*path", to: "errors#catch_404", via: :all
end
