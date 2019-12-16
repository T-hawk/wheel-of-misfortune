include MainHelper

class MainController < ApplicationController
  def index
  end

  def scoreboard
    @games = FinishedGame.all
    @victorious_teams = []

    @games.each do |game|
      teams = eval game.teams
      @victorious_teams << {victorious_team: teams[game.victorious_team], date: game.updated_at}
    end

    limit = 50
    @ordered_teams = MainHelper.sort_teams(@victorious_teams)

    if @ordered_teams.length > limit
      @ordered_teams.slice!(limit, @ordered_teams.length - limit)
    end

  end
end
