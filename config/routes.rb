Rails.application.routes.draw do

#顧客側
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#管理側
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: "public/homes#top"

namespace :admin do
 get 'top'=>"homes#top"
 get 'search'=>"searches#search"
 resources :comics, only:[:index, :show, :edit, :destroy, :update] do
  resources :comic_comments, only:[:index, :destroy]
  end
  #タグ絞り込み表示
  resources :tags do
    get 'comics_tag',to: 'comics#tag_search'
  end
  #ジャンル絞り込み表示
  resources :genres do
    get 'comics_genre',to: 'comics#genre_search'
  end
 resources :customers, only:[:index, :show, :edit, :update] do
   member do
     get :comics
     get :bookmark
     get :draft
   end
 end
 resources :genres, only:[:destroy, :edit, :update]
 resources :tags, only:[:edit, :update, :destroy]
end

scope module: :public do
 post 'customers/guest_sign_in', to: 'customers#guest_sign_in'
 get 'search'=>"searches#search"
 resources :comics, only:[:index, :new, :create, :show, :edit, :destroy, :update] do
  collection do
    post :check
    post :back
    get :spoiler
    get :no_spoiler
  end
  resources :comic_comments, only: [:index, :create, :destroy]
  resource :bookmark, only: [:create, :destroy]
  end
  #タグ絞り込み表示
  resources :tags do
    get 'comics_tag',to: 'comics#tag_search'
  end
  #ジャンル絞り込み表示
  resources :genres do
    get 'comics_genre',to: 'comics#genre_search'
  end
 resources :customers, only:[:show, :edit, :update] do
   collection do
     get :quit
   end
   member do
     get :comics
     get :bookmark
     get :draft
     patch :withdrawal
   end
 end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
