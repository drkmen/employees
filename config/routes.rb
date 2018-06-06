# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees, controllers: { sessions: 'sessions', invitations: 'invitations' }

  resources :employees
  resources :projects, except: %i[show index]
  resources :skills, except: %i[show index]
  resources :archive, only: %i[index destroy]
  root to: 'employees#index'
end
