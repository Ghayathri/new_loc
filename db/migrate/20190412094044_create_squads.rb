class CreateSquads < ActiveRecord::Migration[5.1]
  def change
    create_table :squads do |t|
    	t.integer :match_id
    	t.integer :user_id
    	t.string  :player_ids
      t.timestamps
    end
    add_index :squads, :match_id
  end
end
