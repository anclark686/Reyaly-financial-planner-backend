Rails.application.routes.draw do
  
  resources :users do
    post "download"
    resources :expenses
    resources :paychecks
    resources :debts
  end
end
