Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    scope '/admin' do
      resources :users
      root 'users#index', as: 'admin_root'
    end
  end

  root 'home#index'

end
