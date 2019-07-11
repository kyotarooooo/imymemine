Rails.application.routes.draw do

	root "homes#about"
	get "users/:id/top/" => "users#top", as: "mypage"
  get "inquiry" => "inquiry#index" #入力画面
  post "inquiry/confirm" => "inquiry#confirm" #確認画面
  post "inquiry/thanks" => "inquiry#thanks" #送信完了画面


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
	resources :coordinates, only:[:new, :create, :index, :show, :edit, :update, :destroy]
	resources :users, only:[:index, :show, :edit, :update]

namespace :admins do
	resources :coordinates, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show]
    get "/top" => "users#top", as: "admin_mypage"
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
