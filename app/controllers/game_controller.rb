require "pp"

class GameController < ApplicationController

  def new
  end

  def create
    @data = game_data

    @teams = @data["teams"]
    @game = ActiveGame.new(teams: @teams)
    @wheel = Wheel.new(sections: @data["wheel"])
    @wheel.save
    @game.wheel = @wheel
    @game.save

    pp "-------------------------------------------------------------------------------------------"
    pp "Team data..............................."
    pp @game[:teams]
    pp "Wheel data..............................."
    pp @wheel
    pp "-------------------------------------------------------------------------------------------"

    redirect_to @game
  end

  def play
    @game = ActiveGame.find(params[:game_id])
  end

  def end
  end

  def show
  end

  def game_data
    JSON.parse params[:game]
  end
end
