Rails.application.routes.draw do

  root "main#index"
  # Main
  get "/scoreboard", to: "main#scoreboard"

  # Game
  post "/play", to: "game#play"
  # post "/play/start", to: "game#start"
  get "/new", to: "game#new"
  get "/game", to: "game#show"

  # get "/new", to: ""
end
