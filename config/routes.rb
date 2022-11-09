Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  #custome router devise
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" },controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions'
  }, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  resource :posts do
    collection do
      get :all_posts_guest
      get :my_posts
      get :new_post_guest
      post :create_post_guest
      patch :confirm_post_guest
    end
  end
  resources :users
  resources :posts
  root to: "posts#index"
end
