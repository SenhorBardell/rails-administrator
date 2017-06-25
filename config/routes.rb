Rails.application.routes.draw do
  resources :users do
    post 'email', on: :member
    post 'auth', on: :collection
  end
end
