Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  devise_scope :user do
    root to: 'v1/dashboards#index'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  namespace :v1 do
    resources :banks
    resources :providers
    resources :bank_accounts
    resources :dashboards, only: [:index]
  end
end

