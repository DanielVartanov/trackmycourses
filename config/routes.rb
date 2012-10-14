TrackMyCourses::Application.routes.draw do
  resources :dashboard, only: :index
  resources :courses

  resource :account do
    resources :subscriptions
  end

  root :to => 'home#index'
end
