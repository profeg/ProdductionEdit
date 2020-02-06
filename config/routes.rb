Rails.application.routes.draw do

  get '/welcome', to: 'welcome#index'
  post '/welcome', to: 'welcome#create'

  get '/welcome/file', to: 'welcome#file'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'
end
