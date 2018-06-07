class RenameUserinGamestoP2 < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :user, :p2
  end
end
