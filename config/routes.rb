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
  end

end
