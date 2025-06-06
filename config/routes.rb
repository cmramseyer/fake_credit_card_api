Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :check_credit_card, only: [:index]
  resources :credit_cards, only: [:index] do
    resources :payments, only: [:index, :create]
  end
  
  devise_scope :user do
    post '/signup', to: 'registrations#create'
  end
  match '*unmatched', to: 'application#route_not_found', via: :all
end
