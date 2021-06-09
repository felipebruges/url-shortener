Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :short_urls, only: %i[create show]
    end
  end
  get '/:id', to: 'api/short_urls#show'
end
