UnilevelSettlement::Engine.routes.draw do
  resources :providers, only: %i[index new create edit update]
  resources :provisions_templates, only: %i[index new create edit update destroy]

  namespace :payouts do
    resources :payout_runs, only: %i[index new create] do
      get 'start', on: :collection
    end
  end
end
