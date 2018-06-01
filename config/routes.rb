Rails.application.routes.draw do
  devise_for :employees

  resources :employees
  root to: 'employees#index'
end
