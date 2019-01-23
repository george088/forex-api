Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  # get 'index' => 'index#index'
  root to: 'index#index'

  get 'new_key' => 'index#new_key'
  get 'upgrade' => 'index#upgrade'
  put 'upgrading' => 'index#upgrading'
end
