Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
  resources :posts do
    resources :comments, except: :show
  end
  resources :categories, except: :show
  resource :user, only: [:show, :edit, :update]
  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index, :show], defaults: { format: :json } do
        resources :provinces, only: :index
      end
      resources :provinces, only: [:index, :show], defaults: { format: :json } do
        resources :cities, only: :index
      end
      resources :cities, only: [:index, :show], defaults: { format: :json } do
        resources :barangays, only: :index
      end
      resources :barangays, only: [:index, :show], defaults: { format: :json }
    end
  end
end
