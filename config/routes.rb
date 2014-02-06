Bike::Application.routes.draw do

  resources :bikes, :users, :sessions, :journeys

  get "/" => redirect("/bikethere")
  get "/bikethere" => "bikes#index"

  get "/signup" => "users#new"
  delete "/signout", to: "sessions#destroy"
  get "/signin" => "sessions#new"
  
end
 

#        users GET    /users(.:format)             users#index
#              POST   /users(.:format)             users#create
#     new_user GET    /users/new(.:format)         users#new
#    edit_user GET    /users/:id/edit(.:format)    users#edit
#         user GET    /users/:id(.:format)         users#show
#              PATCH  /users/:id(.:format)         users#update
#              PUT    /users/:id(.:format)         users#update
#              DELETE /users/:id(.:format)         users#destroy
#     sessions GET    /sessions(.:format)          sessions#index
#              POST   /sessions(.:format)          sessions#create
#  new_session GET    /sessions/new(.:format)      sessions#new
# edit_session GET    /sessions/:id/edit(.:format) sessions#edit
#      session GET    /sessions/:id(.:format)      sessions#show
#              PATCH  /sessions/:id(.:format)      sessions#update
#              PUT    /sessions/:id(.:format)      sessions#update
#              DELETE /sessions/:id(.:format)      sessions#destroy
#     journeys GET    /journeys(.:format)          journeys#index
#              POST   /journeys(.:format)          journeys#create
#  new_journey GET    /journeys/new(.:format)      journeys#new
# edit_journey GET    /journeys/:id/edit(.:format) journeys#edit
#      journey GET    /journeys/:id(.:format)      journeys#show
#              PATCH  /journeys/:id(.:format)      journeys#update
#              PUT    /journeys/:id(.:format)      journeys#update
#              DELETE /journeys/:id(.:format)      journeys#destroy
#       signup GET    /signup(.:format)            users#new
#      signout DELETE /signout(.:format)           sessions#destroy
#       signin GET    /signin(.:format)            sessions#new