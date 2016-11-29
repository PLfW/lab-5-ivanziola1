Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  resources :genres, only: [:index]
  resources :books, only: [:index, :create, :show]
  namespace :api do
    namespace :v1 do
      resources :genres, only: [:index]
      resources :books, only: [:index, :create, :show]
    end
  end
  namespace :admin do
    resources :genres, except:[:show]
    resources :books, except:[:show]
    post 'books/:id/approve', to: 'books#approve', as: 'approve_book'
  end
  get 'static_pages/api', as: 'api'
end
