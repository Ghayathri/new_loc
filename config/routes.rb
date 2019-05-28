Rails.application.routes.draw do
  
  devise_for :users
  root "homes#index"

  resources :homes
  resources :dashboards
  resources :matches do
  	resources :live do
  		collection do
  			get 'move_to_live'
  		end
  	end
  end
  resources :squads 
  resources :profiles


  #============================= Admin Resoursec =====================================

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'update_matches', to: 'admin/matches#update_matches'
  post 'match_summary/:id', to: 'admin/matches#match_summary', as: 'match_summary'
  post 'create_squad/:id', to: 'admin/matches#create_squad', as: 'create_squad'

  get  'publish/:id', to: 'admin/matches#publish', as: "publish"
  post  'finish_setup/:id', to: 'admin/matches#finish_setup', as: 'finish_setup'

end
