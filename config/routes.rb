# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#logout'
    post 'auth/:provider', to: 'auth#request', as: :auth_request

    root 'bulletins#index'
    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch 'to_moderate'
        patch 'archive'
      end
    end
    resources :profiles, only: %i[show]

    namespace :admin do
      root 'home#index'
      resources :bulletins do
        member do
          patch 'publish'
          patch 'reject'
          patch 'archive'
        end
      end
      resources :categories
      resources :users
    end
  end
end
