Rails.application.routes.draw do
  #custome router devise
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" },controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions'
  }
  resources :users
  root to: "main#index"
end
