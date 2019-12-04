class AddNameToTeamsAndChangeMembersToArray < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :name, :string

    remove_column :teams, :members
    add_column :teams, :members, :text, array: true
  end
end
