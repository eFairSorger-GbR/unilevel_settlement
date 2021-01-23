UnilevelSettlement::Engine.routes.draw do
  # ----- Provider routes -----
  resources :providers, only: %i[index new create edit update]
  resources :provisions_templates, only: %i[index new create edit update]
end
