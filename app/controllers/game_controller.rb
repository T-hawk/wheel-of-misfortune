require "pp"
require "json"
require "open-uri"

class GameController < ApplicationController

  def new
    @default_wheel = File.read("app/assets/json/default_wheel.json")
    @christmas_wheel = File.read("app/assets/json/christmas_wheel.json")
  end

  def create
    @data = game_data

    @teams = @data["teams"]

    @newWheel = Wheel.new(sections: @data["wheel"])
    @wheel = Wheel.where(sections:  @newWheel.sections).first_or_create

    @game = @wheel.active_games.create(teams: @teams)
    redirect_to @game
  end

  def save
    @data = game_data

    @teams = @data["teams"]

    @game = ActiveGame.find(@data["game_id"])
    @game.teams = @teams
    @game.save
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
