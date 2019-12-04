class CreateActiveGames < ActiveRecord::Migration[6.0]
  def change
    create_table :active_games do |t|
      t.integer :wheel_id
      t.integer :current_score

      t.timestamps
    end
  end
end
