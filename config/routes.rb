Rails.application.routes.draw do

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  #ゲストログイン用
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get 'about', to: 'homes#about', as: :about

    get "/mypage", to: "users#mypage", as: "mypage"
    resources :users, only: [:edit,:show,:update,:destroy] do
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end

    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end

    get "/search", to: "searches#search"
  end

  # 管理者側のルーティング設定
  namespace :admin do
    get "", to: "homes#top"

    resources :users, only: [:show, :destroy]
    resources :posts, only: [:show, :index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
