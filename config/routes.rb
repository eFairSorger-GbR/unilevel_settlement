UnilevelSettlement::Engine.routes.draw do
  # ----- Provider routes -----
  resources :providers, only: %i[index new create update]
end
