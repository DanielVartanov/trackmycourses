TrackMyCourses::Application.routes.draw do
  resources :dashboard
  resources :courses

  resource :account do
    get :sign_out, on: :member
    get :subscribe, on: :member
    resources :subscriptions
  end

  root :to => 'home#index'
  match "/auth/:provider/callback" => "accounts#create"
end
