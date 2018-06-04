Rails.application.routes.draw do
  devise_for :employees

  resources :employees
  resources :projects, except: [ :show, :index ]
  root to: 'employees#index'
end
