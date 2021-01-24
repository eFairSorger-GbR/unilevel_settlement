UnilevelSettlement::Engine.routes.draw do
  resources :payout_runs, only: %i[index]
  resources :providers, only: %i[index new create edit update]
  resources :provisions_templates, only: %i[index new create edit update destroy]
end
