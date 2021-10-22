Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # get "/teams", to: "teams#index"
  # get "/teams/new", to: "teams#new"
  get '/search', to: 'teams#search'
  resources :teams do
    get "/member_add", to: "teams#member_add"
    resources :members, only: [:index, :create, :destroy]
    
  end
  resources :projects
  
end
