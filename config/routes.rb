Bike::Application.routes.draw do

  resources :bikes, :users, :sessions, :journeys

  get "/" => redirect("/bikethere")
  get "/bikethere" => "bikes#index"

  get "/signup" => "users#new"
  delete "/signout", to: "sessions#destroy"
  get "/signin" => "sessions#new"
  
end
 