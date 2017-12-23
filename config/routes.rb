Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { passwords: 'devise/password_resets' }

  post '/graphql', to: 'graphql#execute'

  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show'
  post '/products/', to: 'products#create'
  put '/products/:id', to: 'products#update'
  delete '/products/:id', to: 'products#delete'
end
