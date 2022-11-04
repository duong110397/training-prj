Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  #custome router devise
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" },controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions'
  }
  get "posts/all_posts_guest", to: 'posts#show_all_post_guest'
  get "posts/my_posts", to: 'posts#postme'
  post "posts/guest", to: 'posts#create_post_guest'
  patch "posts/guest", to: 'posts#approve_post_guest'
  get "posts/guest", to: 'posts#show_post_guest'
  resources :users
  resources :posts
  root to: "posts#index"
end
