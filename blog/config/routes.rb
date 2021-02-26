Rails.application.routes.draw do

  root "articles#index"

  resources :articles do
    resources :comments
  end
# Rather than manually specify each line, we can use resources to map default CRUD paths
# See a route summary via: bin/rails routes
#  get "/articles", to: "articles#index"
#  get "/articles/:id", to: "articles#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
