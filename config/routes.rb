Rails.application.routes.draw do

  root "main#index"
  # Main
  get "/scoreboard", to: "main#scoreboard"

  # Game
  post "game/create", to: "game#create"
  # post "/play/start", to: "game#start"
  get "/new", to: "game#new"
  get "/game", to: "game#show"

  get "/play/:game_id", to: "game#play", as: :active_game

  # get "/new", to: ""
end
