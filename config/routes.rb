Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [ :update, :edit ] do
    resources :user_activities, only: [ :create, :new ] do
      get 'search', on: :collection
    end
    resources :activities, path: '/activitiés', only: [ :index ]
  end

  resources :user_activities, only: [:destroy, :update, :edit ]

end
