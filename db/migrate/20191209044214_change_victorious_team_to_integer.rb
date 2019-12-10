class ChangeVictoriousTeamToInteger < ActiveRecord::Migration[6.0]
  def change
    remove_column :finished_games, :victorious_team
    add_column :finished_games, :victorious_team, :integer
  end
end
