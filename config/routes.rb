UnilevelSettlement::Engine.routes.draw do
  resources :providers, only: %i[index new create edit update]
  resources :provisions_templates, only: %i[index new create edit update destroy]

  namespace :payouts do
    resources :payout_runs, only: %i[index show new create] do
      get 'start', on: :collection

      resources :payout_invoices, only: %i[show] do
        get 'create_all', on: :collection
      end

      resources :providers, only: %i[index create update] do
        get 'check_provider_validity', on: :collection
      end

      member do
        get 'flow'
        delete 'cancel'
      end
    end
  end
end
