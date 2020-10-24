Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :user do
    get 'inquiry/index'
    get 'inquiry/confirm'
    get 'inquiry/thanks'
  end
  get 'welcome/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'user/home#top'

  namespace :user do
    get "home/top" => "home#top"
    get "home/about" => "home#about"
    get   'inquiry'         => 'inquiry#index'     
    post  'inquiry/confirm' => 'inquiry#confirm'   
    post  'inquiry/thanks'  => 'inquiry#thanks'
    resources :users, only: [:show, :edit, :update]
    get "users/follow_index/:id" => "users#follow_index",as: "users_follow_index"
    get "users/follower_index/:id" => "users#follower_index",as: "users_follower_index"
    resources :relationships, only: [:create, :destroy]
    resources :messages, only: :create
    resources :rooms, only: [:create,:show]
    resources :spotify, only: :index
    get "spotify/artist_show/:id" => "spotify#artist_show" , as: "spotify_artist_show"
    get "spotify/album_show/:id" => "spotify#album_show" , as: "spotify_album_show"
    get "spotify/song_show/:id" => "spotify#song_show" , as: "spotify_song_show"
    get "spotify/new_releases" => "spotify#new_releases", as: "spotify_new_releases"
    get "spotify/charged_ups" => "spotify#charged_ups", as: "spotify_charged_ups"
    resources :artist_comments, only: [:create, :destroy, :update]
    resources :artist_ratings, only: [:create, :update]
    resources :album_comments, only: [:create, :destroy, :update]
    resources :album_ratings, only: [:create, :update]
    resources :song_comments, only: [:create, :destroy, :update]
    resources :song_ratings, only: [:create, :update]
    resources :song_favorites, only: [:index, :create, :destroy]
    resources :song_impressions, only: [:index]
    resources :notifications, only: :index
    resources :browsing_history, only: :index
  end

end
