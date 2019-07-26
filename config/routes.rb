Rails.application.routes.draw do

	root "homes#about"
	get "users/:id/top/" => "users#top", as: "mypage"
  get "coordinates/mens" => "coordinates#mens_coordinate", as: "mens"
  get "coordinates/ladies" => "coordinates#ladies_coordinate", as: "ladies"
  get "coordinates/search" => "coordinates#search"
  post "coordinates" => "coordinates#create"
  post "items" => "items#create"


devise_for :admins, controllers: {
  	sessions:      'admins/sessions',
  	passwords:     'admins/passwords',
  	registrations: 'admins/registrations'
}
devise_for :users, controllers: {
	sessions:      'users/sessions',
  	passwords:     'users/passwords',
  	registrations: 'users/registrations'
}
  resources :users, only:[:index, :show, :edit, :update]
  get "users/:id/resign" => "users#resign", as: "resign"
  patch "users/:id/resign_confirm" => "users#resign_confirm", as: "resign_confirm"
	resources :coordinates, only:[:index, :new, :show, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end
  resources :items, only:[:index, :show]
  resources :messages, only:[:create]
  resources :rooms, only:[:create, :show, :index]


namespace :admins do
	resources :coordinates, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    get "/top" => "users#top", as: "admin_mypage"
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
