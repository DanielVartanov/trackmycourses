TrackMyCourses::Application.routes.draw do
  resources :dashboard, only: :index
  resources :users, only: :new
  resources :courses
  resources :subscriptions

  resource :account do
    resources :subscriptions
  end

  root :to => 'home#index'
end
