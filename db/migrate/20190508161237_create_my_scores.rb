class CreateMyScores < ActiveRecord::Migration[5.1]
  def change
    create_table :my_scores do |t|
    	t.integer :user_id
      t.string  :player_name
      t.integer :batting_score
      t.integer :bowling_score
      t.integer :fielding_score
      t.integer :total_score
      t.integer :ranking
      t.integer :match_id
      t.integer :pid
      t.timestamps
    end
    add_index :my_scores, :user_id
    add_index :my_scores, :match_id
  end
end
