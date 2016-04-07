Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  authenticate :user do
    scope '/admin' do
      resources :users do
        get '/posts/', to: 'users#user_posts', as: 'user_posts'
        get '/comments/', to: 'users#user_comments', as: 'user_comments'
      end
      resources :posts
      resources :comments
      get '/comments/:id/approve_comment', to: 'comments#approve_comment', as: 'approve_comment'
      get '/comments/:id/disapprove_comment', to: 'comments#disapprove_comment', as: 'disapprove_comment'
      resources :categories
      resources :pages
      root 'users#index', as: 'admin_root'
    end
  end
  root 'home#index'

end
