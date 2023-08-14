Rails.application.routes.draw do
  root "application#index"
  resources :savings, only: [:index]
  resources :converter, only: [:index]
  
  resources :users do
    post "download"
    resources :expenses, only: [:index, :create, :update, :destroy]
    resources :debts, only: [:index, :create, :update, :destroy]
    resources :accounts, only: [:index, :create, :update, :destroy]

    resources :paychecks, only: [:index] do
      resources :one_time_expenses, only: [:index, :create, :update, :destroy]
    end
  end
end
