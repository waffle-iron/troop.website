Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#home'
  resources :profiles, only: [:index, :show]
  resources :scouts
  resources :positions
  resources :ranks
  resources :patrols
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
