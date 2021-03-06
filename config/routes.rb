# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees, controllers: {
    sessions: 'sessions',
    invitations: 'invitations',
    passwords: 'passwords'
  }

  resources :employees, except: %i[new edit create] do
    patch :skill_experience
    resources :projects, except: %i[edit show index]
  end
  resources :skills, except: %i[new edit]
  resources :archive, only: %i[index] do
    collection do
      delete 'destroy/:employee_id', action: :destroy, as: :destroy
      patch 'restore/:employee_id', action: :restore, as: :restore
    end
  end
  resources :offices, only: %i[index create update destroy]
  resources :departments, only: %i[create update destroy]

  post :wishes, to: 'application#wishes'
  root to: 'employees#index'
end
