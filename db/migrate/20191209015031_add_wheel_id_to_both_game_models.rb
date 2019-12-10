class AddWheelIdToBothGameModels < ActiveRecord::Migration[6.0]
  def change
    remove_column :wheels, :active_game_id
    add_column :active_games, :wheel_id, :integer
    add_column :finished_games, :wheel_id, :integer
  end
end
