class CreateMatchExtras < ActiveRecord::Migration[5.1]
  def change
    create_table :match_extras do |t|
    	t.integer :match_id
    	t.text    :team_name
    	t.text    :details
    	t.integer :total_runs
      t.timestamps
    end
    add_index :match_extras, :match_id
  end
end
