Rails.application.routes.draw do
  resources :images
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'home#index'
  authenticate :user do
    
    scope '/admin' do
      resources :users do
        get '/posts/', to: 'users#user_posts', as: 'user_posts'
        get '/comments/', to: 'users#user_comments', as: 'user_comments'
      end
      resources :posts
      resources :comments, except: [:new, :create]
      get '/comments/:id/approve_comment', to: 'comments#approve_comment', as: 'approve_comment'
      get '/comments/:id/disapprove_comment', to: 'comments#disapprove_comment', as: 'disapprove_comment'
      resources :categories
      resources :pages
      root 'admin_dashboard#index', as: 'admin_root'
    end

    scope 'profile' do
      root 'user_dashboard#index', as: 'user_root'
    end

  end

end
