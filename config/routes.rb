Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  # get 'index' => 'index#index'
  root to: 'index#index'

  get 'new_key' => 'index#new_key'
  get 'upgrade' => 'index#upgrade'
  put 'upgrading' => 'index#upgrading'

  scope 'api' do
    scope 'v1' do
      get 'tickets_list' => 'api#tickets_list'
      get 'quotes' => 'api#quotes'
    end
  end
end
