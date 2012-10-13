TrackMyCourses::Application.routes.draw do
  resources :dashboard, only: :index
  resources :users, only: :new
  resources :courses
  resources :subscriptions

  root :to => 'home#index'
end
