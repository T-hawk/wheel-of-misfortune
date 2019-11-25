Rails.application.routes.draw do

  root "main#index"

  get "/scoreboard", to: "main#scoreboard"

end
