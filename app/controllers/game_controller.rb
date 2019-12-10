require "pp"
require "json"

class GameController < ApplicationController

  def new
  end

  def create
    @data = game_data

    @teams = @data["teams"]
    @wheel = Wheel.create(sections: @data["wheel"])

    @game = @wheel.active_games.create(teams: @teams)

    redirect_to @game
  end

  def play
    @game = ActiveGame.find(params[:game_id])

    @wheel = eval(@game.wheel.sections)
    @teams = eval(@game.teams)
    @wheel_id = @game.wheel_id
  end

  def end
    @data = game_data

    @teams = @data["teams"]

    ActiveGame.destroy(@data["game_id"])

    @wheel = Wheel.find(@data["wheel_id"])

    @new_game = @wheel.finished_games.create(teams: @teams, victorious_team: @data["victorious_team"])

    redirect_to @new_game
  end

  def show
    @game = FinishedGame.find(params[:game_id])

    @teams = eval(@game.teams)

    @winner = @teams[@game.victorious_team]
  end

  def game_data
    JSON.parse params[:game]
  end
end
