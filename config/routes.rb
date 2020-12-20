UnilevelSettlement::Engine.routes.draw do
  resources :provider, only: %i[index]
end
