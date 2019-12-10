Rails.application.routes.draw do

  root "main#index"

  # Main
  get "/scoreboard", to: "main#scoreboard"

  # Game
  post "game/create", to: "game#create"
  post "game/end", to: "game#end"
  get "/new", to: "game#new"
  get "/game/show/:game_id", to: "game#show", as: :finished_game

  get "/play/:game_id", to: "game#play", as: :active_game
end
