Rails.application.routes.draw do
  devise_for :employees

  root to: 'employees#index'
end
