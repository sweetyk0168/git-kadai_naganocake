Rails.application.routes.draw do
  # devise_for :customers
  # 顧客用
# URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理用
# URL /admin/sign_in ...
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'
  get 'home/about' => 'public/homes#about', as: 'about'
  get 'customers/confirm_withdraw' => 'public/customers#confirm_withdraw'
  patch 'customers/withdraw' => 'public/customers#withdraw'
  get 'customers/information/edit' => 'public/customers#edit'
  patch '/customers/information' => 'public/customers#update'

  #get 'customers/mypage' => 'customers#show'
  scope module: :public do
    resource :customers,only: [:show]
  end

  namespace :admin do
    resources :genres,only: [:index,:create,:edit,:update]
    resources :items,only: [:index, :new, :create, :show, :edit, :update]
    resources :get_image, only: [:new, :index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
