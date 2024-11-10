Rails.application.routes.draw do
  # config/routes.rb

Rails.application.routes.draw do
  # トップページとアバウトページ
  root 'homes#top'
  get '/about', to: 'homes#about'

  # Deviseのルーティング（ユーザー認証）
  devise_for :users

  # ユーザー関連
  resources :users, only: [:show, :edit, :update, :destroy]
  get '/users/:id/mypage', to: 'users#mypage', as: 'mypage'

  # 投稿関連
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:index, :new, :create]
  end

  # コメント関連
  resources :comments, only: [:edit, :update, :destroy]

  # グループ関連
  resources :groups, only: [] do
    resources :mails, only: [:index, :new, :create, :show]
  end

  # 管理者セッション
  namespace :admin do
    resource :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
