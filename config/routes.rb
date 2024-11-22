# config/routes.rb

Rails.application.routes.draw do
  # トップページとアバウトページ
  root 'homes#top'
  get '/about', to: 'homes#about'

  # Deviseのルーティング（ユーザー認証）
  devise_for :users

  # ユーザー関連（mypage_pathがusers#showに対応）
  resources :users, only: [:show, :edit, :update, :destroy]
  get '/mypage', to: 'users#show', as: 'mypage'

  # 投稿関連
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:index, :new, :create, :destroy]
  end

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
