Rails.application.routes.draw do
  resources :savings, only: [:index]
  
  resources :users do
    post "download"
    resources :expenses, only: [:index, :create, :update, :destroy]
    resources :paychecks, only: [:index]
    resources :debts, only: [:index, :create, :update, :destroy]
    resources :accounts, only: [:index, :create, :update, :destroy]
  end
end
