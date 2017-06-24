Rails.application.routes.draw do
  resources :users do
    post 'email', on: :member
  end
end
