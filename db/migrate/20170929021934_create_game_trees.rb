class CreateGameTrees < ActiveRecord::Migration[5.1]
  def change
    create_table :game_trees do |t|

      t.timestamps
    end
  end
end
