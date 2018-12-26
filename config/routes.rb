Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [ :update, :edit ] do
    resources :user_activities, only: [ :create, :new ] do
      get 'search', on: :collection
    end
    resources :activities, path: '/activitiés', only: [ :index ]
    resources :evenements, only: [ :create, :index ]
  end

  resources :user_activities, only: [:destroy, :update, :edit ]

  resources :evenements, only: [ :show, :edit, :destroy, :update ] do
    put 'search_map', on: :member #with id
    put 'update_status_participant', on: :member #with id
    put 'update_materiel', on: :member
    get 'mes_evenements', on: :member
    resources :messages, only: [ :create ]
    resources :participants, only: :create
    # resources :participants, only: :create
  end

  resources :companies, only: [:show, :edit, :update]

end
