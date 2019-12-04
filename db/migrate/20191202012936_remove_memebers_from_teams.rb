class RemoveMemebersFromTeams < ActiveRecord::Migration[6.0]
  def change
    remove_column :teams, :memebers
  end
end
