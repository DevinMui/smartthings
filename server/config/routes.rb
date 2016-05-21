Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :families
      resources :showers do
        member do
          get 'time_stamp_start'
          get 'time_stamp_stop'
        end
      end
    end
  end
end
