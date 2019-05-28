class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
    	t.string  :player
      t.text    :team_name
      t.integer :pid
      t.string  :role
      t.string  :country
      t.text    :img_url
      t.integer :points
      t.integer :match_id
      t.timestamps
    end
    add_index :teams, :match_id
  end
end
