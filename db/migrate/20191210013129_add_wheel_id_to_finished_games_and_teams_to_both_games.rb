class AddWheelIdToFinishedGamesAndTeamsToBothGames < ActiveRecord::Migration[6.0]
  def change
    add_column :finished_games, :wheel_id, :integer
    add_column :finished_games, :teams, :string
    add_column :active_games, :teams, :string
  end
end
