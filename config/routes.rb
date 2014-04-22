Rails.application.routes.draw do
  resources :entries, only: [:create]

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sso', to: redirect('/auth/kosynierzy'), as: :sign_in
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out

  root to: 'timeline#index'
end
