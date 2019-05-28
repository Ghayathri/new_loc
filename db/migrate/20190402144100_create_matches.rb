class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
  		t.integer  :unique_id , :limit => 8
      t.text     :team_2
      t.text     :team_1
      t.string   :test_type
      t.datetime :match_time
      t.boolean	 :squad
      t.text     :toss_wt
      t.text     :winner_team
      t.boolean  :match_started
      t.boolean  :match_ended
      t.boolean  :publish
      t.string   :man_of_the_match
      t.timestamps
    end
  end
end
