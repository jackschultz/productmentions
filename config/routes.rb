Rails.application.routes.draw do
  root to: 'homes#index'

  resources :products, only: [:index, :show]
  resources :product_groups, only: [:index, :show]

end
