class CreateBattings < ActiveRecord::Migration[5.1]
  def change
    create_table :battings do |t|
    	t.integer :match_id
    	t.string  :batsman
			t.text    :team_name
    	t.string  :dismissal
			t.float   :strike_rate
			t.integer :sixes
			t.integer :fours
			t.integer :balls_played
			t.integer :runs
			t.string  :dismissal_info
			t.integer :pid
      t.timestamps
    end
    add_index :battings, :match_id
  end
end
