class CreateBowlings < ActiveRecord::Migration[5.1]
  def change
    create_table :bowlings do |t|
    	t.text    :team_name
    	t.string  :bowler
    	t.integer :sixs
			t.integer :fours
			t.integer :zeros
			t.integer :overs
			t.integer :wickets
			t.integer :runs
			t.integer :maidens
			t.float   :econ
			t.integer :match_id
			t.integer :pid
      t.timestamps
    end
    add_index :bowlings, :match_id
  end
end
