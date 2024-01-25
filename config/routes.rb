Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    root to: 'v1/banks#index'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  namespace :v1 do
    resources :banks
  end
end

