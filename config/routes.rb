require 'sidekiq/web'

ForeverFamilyFoundation::Application.routes.draw do
  ActiveAdmin.routes(self)
  mount Sidekiq::Web, at: '/sidekiq'

  root to: 'site#index'
  # Need this for legacy links hard-coded into Love Knows No Death PDF
  get 'site/page/:id', to: 'site#page'
  # get '/pages/signs-of-life-magazine', to redirect('/', status: 301)
  

  devise_for :users, controllers: {
    registrations: 'registrations',
    invitations: 'invitations',
    sessions: 'sessions'
  }

  devise_scope :user do
    authenticated :user do
      root to: 'users#show', as: :user_profile
    end
  end

  resources :users, only: :show
  resources :pages, only: [:show], controller: :cms_pages
  resources :user_preference_selections, only: [:edit, :update]
  resources :events, only: [:index, :show]

  match '/404', to: 'exceptions#not_found', via: :all
  match '/500', to: 'exceptions#internal_error', via: :all
  match '/422', to: 'exceptions#unacceptable', via: :all

  resources :sitterforms
  resources :mediumforms
  resource :adg_registration

  # billing routes - not in use
  # mount StripeEvent::Engine, at: '/webhooks/stripe'
  # resources :businesses
  # resources :family_member_invitations, only: [:create, :new]
  # resources :family_members, only: [:destroy]
  # resource :pricing, controller: :pricing
  # resource :subscription do
  #   patch :resume
  # end
  # resources :payments
  # resources :charges
  # resource :card
end
