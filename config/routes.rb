# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
    # delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :users, only: %i[index show] do
    resources :invitations do
      member do
        get 'send'
      end
    end
  end
  get '/users/sign_in(.:format)', to: 'devise/sessions#new'
  get '/users/:id/edit(.:format)', to: 'devise/registrations#edit'
  get 'send', action: :send_inviation, controller: 'users'
  get 'accept_friend', action: :accept_invitation, controller: 'users'
  get 'reject_friend', action: :reject_invitation, controller: 'users'

  resources :posts do
    resources :comments
    resources :likes
  end

  get 'about', to: 'application#about'
end
