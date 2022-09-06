Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: "public/homes#top"

namespace :admin do
 get 'top'=>"homes#top"
 get 'search'=>"searchs#search"
 resources :comics, only:[:index, :show, :edit, :destroy, :update]
 resources :genres, only:[:index, :create, :edit, :update]
 resources :customers, only:[:index, :show, :edit, :update]
 resources :tags, only:[:index, :create, :edit, :update]
 resources :companies, only:[:index, :create, :edit, :update]
 resources :comic_comments, only:[:index, :create, :destroy]
end

namespace :public do
 get 'search'=>"searchs#search"
 post 'comics/check', to: 'comics#check', as: "comics/check"
 get 'customers/quit', to: 'customers#quit', as: "customers/quit"
 patch 'customers/withdrawal/:id', to: 'customers#withdrawal', as: "customers/withdrawal"
 resources :comics, only:[:index, :new, :create, :show, :edit, :destroy, :update]
 resources :customers, only:[:show, :edit, :update]
 resources :comic_comments, only:[:index, :create, :destroy]
 resources :genres, only:[:create, :destroy, :edit, :update]
 resources :companies, only:[:create, :destroy, :edit, :update]
 resources :tags, only:[:create, :destroy, :edit, :update]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
