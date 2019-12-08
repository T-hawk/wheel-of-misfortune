class RemoveCurrentScoreFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_column :active_games, :current_score
    remove_column :finished_games, :score
  end
end
