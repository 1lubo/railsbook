# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :users do
    resources :invitations do
      member do
        get 'send'
      end
    end
  end

  get 'send', action: :send_inviation, controller: 'users'
  get 'accept_friend', action: :accept_invitation, controller: 'users'
  get 'reject_friend', action: :reject_invitation, controller: 'users'

  resources :posts do
    resources :comments
    resources :likes
  end
end
