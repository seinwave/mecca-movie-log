# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/ratings', to: 'ratings#index'
  get '/stats', to: 'static_pages#stats'

  post '/ratings', to: 'ratings#create', as: 'add_rating'
  post 'new_movie', to: 'ratings#new_movie', as: 'new_movie'
  post 'select_movie', to: 'ratings#select_movie', as: 'select_movie'

  # Defines the root path route ("/")
  root 'ratings#index'
end
