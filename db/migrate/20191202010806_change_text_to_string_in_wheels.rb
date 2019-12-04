class ChangeTextToStringInWheels < ActiveRecord::Migration[6.0]
  def change
    change_column :wheels, :sections, :string
  end
end
