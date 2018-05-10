Rails.application.routes.draw do
  get '/list_posts' => 'application#list_posts'
  get '/show_post/:id' => 'application#show_post'
  get '/new_post' => 'application#new_post'
  post '/create_post' => 'application#create_post'
end