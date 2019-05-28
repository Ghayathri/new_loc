class Squad < ApplicationRecord

	# Assoications

	belongs_to :match
	belongs_to :user
	serialize  :player_ids, Array


	def get_player(player_id)
		self.match.teams.find(player_id)
	end

	def get_indexs
		 self.player_ids.map{|a| self.player_ids.index(a) }
	end

end
