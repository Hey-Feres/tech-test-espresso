Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'devise/sessions', registrations: 'devise/registrations' }

  get '/mfa/verification_form', to: 'mfa#verification_form'
  post '/mfa/verify', to: 'mfa#verify'

  get '/mfa/new', to: 'mfa#new'
  post '/mfa/create', to: 'mfa#create'
  put '/mfa/update', to: 'mfa#update'

  root to: "home#index"
end
