Rails.application.routes.draw do

  root "main#index"
  # Main
  get "/scoreboard", to: "main#scoreboard"

  # Game
  get "/play", to: "game#play"
  get "/new", to: "game#new"
  get "/game", to: "game#show"

  # get "/new", to: ""
end
