Rails.application.routes.draw do
  resources :paychecks
  resources :users do
    resources :expenses
  end
end
