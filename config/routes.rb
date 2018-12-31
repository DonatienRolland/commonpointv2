Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :sessions => "track_sessions" }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :users, only: [ :update, :edit ] do
    resources :user_activities, only: [ :create, :new ] do
      get 'search', on: :collection
    end
    resources :activities, path: '/activitiés', only: [ :index ]
    resources :evenements, only: [ :create, :index ] do
      get 'historique', on: :collection
    end
  end

  resources :user_activities, only: [:destroy, :update, :edit ]

  resources :evenements, only: [ :show, :edit, :destroy, :update ] do
    put 'search_map', on: :member #with id
    put 'update_status_participant', on: :member #with id
    put 'update_materiel', on: :member
    get 'mes_evenements', on: :member
    get 'update_boosted', on: :member
    resources :messages, only: [ :create ]
    resources :participants, only: :create
    # resources :participants, only: :create
  end
  namespace :charts do
    get 'visitors_by_months'
    get 'visitors_by_days'
    get 'visitors_by_weeks'
    get 'switchPeriod'
  end
  resources :companies, only: [:show, :edit, :update]

end
