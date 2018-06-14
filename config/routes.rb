# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees, controllers: { sessions: 'sessions', invitations: 'invitations' }

  resources :employees, except: %i[new edit create] do
    patch :skill_experience
    resources :projects, except: %i[edit show index]
  end
  resources :skills, except: %i[show index]
  resources :archive, only: %i[index destroy]
  root to: 'employees#index'
end
