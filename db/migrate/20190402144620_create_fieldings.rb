class CreateFieldings < ActiveRecord::Migration[5.1]
  def change
    create_table :fieldings do |t|
    	t.text    :fielder
    	t.integer :runout
      t.integer :stumped
      t.integer :bowled
      t.integer :lbw
      t.integer :catch
      t.text    :team_name
      t.integer :match_id
      t.integer :pid
      t.timestamps
    end
    add_index :fieldings, :match_id
  end
end
