UnilevelSettlement::Engine.routes.draw do
  resources :providers, only: %i[index new create edit update]
  resources :provisions_templates, only: %i[index new create edit update destroy]

  namespace :payouts do
    resources :payout_runs, only: %i[index new create] do
      get 'start', on: :collection

      member do
        get 'flow'
        delete 'cancel'
        resources :providers, only: %i[index create update] do
          get 'check_provider_validity', on: :collection
        end
      end
    end
  end
end
