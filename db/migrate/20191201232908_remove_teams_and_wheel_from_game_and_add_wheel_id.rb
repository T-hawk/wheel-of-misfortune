class RemoveTeamsAndWheelFromGameAndAddWheelId < ActiveRecord::Migration[6.0]
  def change
    remove_column :active_games, :wheel
    remove_column :finished_games, :wheel
    add_column :active_games, :wheel_id, :integer
    add_column :finished_games, :wheel_id, :integer
  end
end
