require "devise"

Rails.application.routes.draw do
  devise_for :editors

  # لوحة الـ CMS للمحررين
  namespace :cms do
    root to: "episodes#index"
    resources :episodes, only: [:index, :new, :create, :show, :edit, :update]
  end

  namespace :discovery do
    resources :episodes, only: [:index, :show]
    root to: "episodes#index"
  end
  get "/discover", to: "discovery/episodes#index", as: :discovery_home

  authenticated :editor do
    root to: "cms/episodes#index", as: :authenticated_root
  end
  unauthenticated do
    root to: redirect("/editors/sign_in"), as: :unauthenticated_root
  end

  # resources :episodes, only: [:index, :show]
end
