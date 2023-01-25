Rails.application.routes.draw do
  resources :users
  # nest comments routes in thread_pages routes
  resources :thread_pages do
    resources :comments
  end
  post "/login", to: "users#login" # login route
  get "/login", to: "users#auto_login" #auto login whenver frontend page refresh
  # autocomplete dropdown for search bar (search by title and tags)
  post "/thread_pages/search/title/autocomplete", to: "thread_pages#search_title_autocomplete"
  post "/thread_pages/search/tags/autocomplete", to: "thread_pages#search_tags_autocomplete"
  # search bar result on click of search button (search by title and tags)
  post "/thread_pages/search/title", to: "thread_pages#search_title"
  post "/thread_pages/search/tags", to: "thread_pages#search_tags"
  # current user's created threads
  get "/mythreads/:user_id", to: "thread_pages#mythreads"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "thread_pages#index"
end
