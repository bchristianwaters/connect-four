class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :type, :game_type
  end
end
