class CreateGameStates < ActiveRecord::Migration[5.1]
  def change
    create_table :game_states do |t|

      t.timestamps
    end
  end
end
