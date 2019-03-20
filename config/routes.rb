Rails.application.routes.draw do
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get 'players/index'

  resources :players
  
  root 'welcome#index'

 # root 'players#index'
end
