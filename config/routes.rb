Rails.application.routes.draw do
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
      resources :images
      resources :forum_posts
      resources :forum_categories
      resources :forum_replies
      root 'admin_dashboard#index', as: 'admin_root'
    end

    get '/profile', to: 'user_dashboard#index', as: 'user_dashboard'
    resources :conversations, only: [:index, :show, :destroy] do
      member do
        post :reply
        post :restore
        post :mark_as_read
      end
      collection do
        delete :empty_trash
      end
    end
    resources :messages, only: [:new, :create]
  end

  get '', to: 'home#index', as: 'home'
  get '/post/:id', to: 'home#show_post', as: 'show_post'
  get '/:id', to: 'home#show_page', as: 'show_page'
  get '/user/:id', to: 'home#show_user_profile', as: 'show_user_profile'
  get '/category/:id', to: 'home#show_category', as: 'show_category'

end
