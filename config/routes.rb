Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users, ActiveAdmin::Devise.config


  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
