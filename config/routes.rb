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
    resources :spotify, only: [:index]
    get "spotify/artist_show/:id" => "spotify#artist_show" , as: "spotify_artist_show"
    get "spotify/album_show/:id" => "spotify#album_show" , as: "spotify_album_show"
    get "spotify/song_show/:id" => "spotify#song_show" , as: "spotify_song_show"
  end

end
