class ChangeGameToFinishedGameAndAddActiveGame < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :winners
    remove_column :games, :losers
    add_column :games, :victorious_team, :string
    rename_table :games, :finished_games
  end
end
