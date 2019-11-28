class AddWinnersAndLosers < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :winners, :string
    add_column :games, :losers, :string
  end
end
