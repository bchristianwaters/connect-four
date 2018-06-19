class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :board
      t.string :turn
      t.integer :moves
      t.integer :p1
      t.integer :p2
      t.string :state

      t.timestamps
    end
  end
end
