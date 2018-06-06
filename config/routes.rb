# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees

  resources :employees
  resources :projects, except: %i[show index]
  resources :skills, except: %i[show index]
  resources :archive, only: %i[index destroy]
  root to: 'employees#index'
end
