Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :readings, only: [:create, :show]
      get 'thermostats/stats' => 'thermostats#stats'
    end
  end

  match '*path', :to => 'application#routing_error', :via => :all

end
