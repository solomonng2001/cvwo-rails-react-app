Rails.application.routes.draw do
  resources :users
  resources :thread_pages do
    resources :comments
  end
  post "/login", to: "users#login"
  get "/login", to: "users#auto_login"
  post "/thread_pages/search/title/autocomplete", to: "thread_pages#search_title_autocomplete"
  post "/thread_pages/search/tags/autocomplete", to: "thread_pages#search_tags_autocomplete"
  post "/thread_pages/search/title", to: "thread_pages#search_title"
  post "/thread_pages/search/tags", to: "thread_pages#search_tags"
  get "/mythreads/:user_id", to: "thread_pages#mythreads"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "thread_pages#index"
end
