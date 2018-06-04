class AddGameToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :game, foreign_key: true
  end
end
