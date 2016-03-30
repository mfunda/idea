Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    scope '/admin' do
      resources :users
      resources :posts
      resources :categories
      root 'users#index', as: 'admin_root'
    end
  end

  root 'home#index'

end
