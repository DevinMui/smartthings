Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :families
      resources :sessions
      resources :showers
      get 'time_stamp_start' => 'showers#time_stamp_start'
      get 'time_stamp_end' => 'showers#time_stamp_end'
    end
  end
end
