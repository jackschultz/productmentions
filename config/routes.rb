Rails.application.routes.draw do
  root to: 'homes#index'

  get 'search' => 'searches#index'

  resources :products, only: [:index, :show]
  resources :product_groups, only: [:index, :show]
  resources :subsites, only: [:index, :show]
  resources :mentions, only: [:index]

end
