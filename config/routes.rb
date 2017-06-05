Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      resources :routes, only: [:new]
    end
  end
end
