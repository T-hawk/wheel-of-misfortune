require "pp"

class GameController < ApplicationController

  def new
    @game = Game.new()
  end

  def play
    @data = game_data

    @teams = @data[:teams]
    @wheel = @data[:wheel]
    pp "-------------------------------------------------------------------------------------------"
    pp params
    pp @data
    pp "-------------------------------------------------------------------------------------------"
  end

  def end
  end

  def show
  end

  def game_data
    JSON.parse params[:game]
  end
end
