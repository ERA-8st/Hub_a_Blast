Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'user/home#top'

  namespace :user do
    get "home/top" => "home#top"
    get "home/about" => "home#about"
    get "home/inquiry" => "home#inquiry"
    resources :users, only: [:show, :edit, :update]
    resources :spotify, only: [:index]
    get "spotify/artist_show/:id" => "spotify#artist_show" , as: "spotify_artist_show"
    get "spotify/album_show/:id" => "spotify#album_show" , as: "spotify_album_show"
    get "spotify/song_show/:id" => "spotify#song_show" , as: "spotify_song_show"
    get "spotify/new_releases" => "spotify#new_releases", as: "soptify_new_releases"
    get "spotify/charged_ups" => "spotify#charged_ups", as: "soptify_charged_ups"
    resources :artist_comments, only: [:create, :destroy, :update]
    resources :artist_ratings, only: [:create, :update]
    resources :album_comments, only: [:create, :destroy, :update]
    resources :album_ratings, only: [:create, :update]
    resources :song_comments, only: [:create, :destroy, :update]
    resources :song_ratings, only: [:create, :update]
  end

end
