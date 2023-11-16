Rails.application.routes.draw do
  root "fotos#index"
  resources :fotos
end

