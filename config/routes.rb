Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  authenticate :user do
    scope '/admin' do
      resources :users do
        get '/posts/', to: 'users#user_posts', as: 'user_posts'
        get '/comments/', to: 'users#user_comments', as: 'user_comments'
      end
      resources :posts do
        resources :comments
      end
      resources :categories
      resources :pages
      root 'users#index', as: 'admin_root'
    end
  end
  root 'home#index'

end
