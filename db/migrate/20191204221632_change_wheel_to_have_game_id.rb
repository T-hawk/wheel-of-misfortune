class ChangeWheelToHaveGameId < ActiveRecord::Migration[6.0]
  def change
    remove_column :active_games, :wheel_id, :integer
    remove_column :finished_games, :wheel_id, :integer
    add_column :wheels, :active_game_id, :integer
  end
end
