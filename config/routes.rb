Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'

  namespace :api do
    namespace :v1 do
      resources :people
      resources :companies, only: [:index, :create], defaults: { format: 'json' }
    end
  end
end
