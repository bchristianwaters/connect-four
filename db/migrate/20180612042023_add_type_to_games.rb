class AddTypeToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :type, :string
  end
end
