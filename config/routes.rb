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
 get 'customers/comics/:id', to:'customers#comics', as: "customers/comics"
 get 'customers/bookmark/:id', to:'customers#bookmark', as: "customers/bookmark"
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
     get :draft
   end
 end
 resources :genres, only:[:index, :create, :edit, :update]
 resources :tags, only:[:index, :create, :edit, :update, :destroy]
end

namespace :public do
 post 'customers/guest_sign_in', to: 'customers#guest_sign_in'
 get 'search'=>"searches#search"
 post 'comics/check', to: 'comics#check', as: "comics/check"
 post 'comics/back', to: 'comics#back', as: "comics/back"
 get 'customers/comics/:id', to:'customers#comics', as: "customers/comics"
 get 'customers/bookmark/:id', to:'customers#bookmark', as: "customers/bookmark"
 get 'customers/quit', to: 'customers#quit', as: "customers/quit"
 patch 'customers/withdrawal/:id', to: 'customers#withdrawal', as: "customers/withdrawal"
 resources :comics, only:[:index, :new, :create, :show, :edit, :destroy, :update] do
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
 resources :customers, only:[:show, :index, :edit, :update] do
   member do
     get :draft
   end
 end
 resources :genres, only:[:create, :destroy, :edit, :update]
 resources :tags, only:[:create, :destroy, :edit, :update, :index]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
