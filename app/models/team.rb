class Team < ApplicationRecord

	# Relationships
	belongs_to :match

	after_create :get_team_details

	def get_team_details
		url = "http://cricapi.com/api/playerStats?apikey=WJECv6admYcdFNGafb1R2uamPp43&pid=#{self.pid}"
		response = HTTParty.get(url)
		parser = Yajl::Parser.new
		@data = parser.parse(response.body)
		self.update!(img_url: @data["imageURL"], country: @data["country"], role: @data["playingRole"].present? ? @data["playingRole"] : "Allrounder")
	end

	def get_role
		case self.role
		when "Wicketkeeper batsman"
			return "Wicketkeeper"
		when "Bowler"
			return "Bowler"
		when "Allrounder"
			return "Allrounder"
		when "Opening batsman"
			return "Batsman"
		when "Top-order batsman"
			return "Batsman"	
		when "Batsman"
			return "Batsman"
		when "Middle-order batsman"
			return "Batsman"
		end
	end

	def get_country
		self.country
	end


	def get_points(user, match)
		bv = match.battings.find_by(pid: self.pid)
		bov = match.bowlings.find_by(pid: self.pid)
		fv = match.fieldings.find_by(pid: self.pid)
		b_points = 0
		bo_points = 0
		f_points = 0
		if bv.present?
			b_points = (bv.runs * 1) + (bv.fours * 1 )+ (bv.sixes * 2) + ((bv.runs - bv.balls_played) * 2)
			b_points = b_points + 25 if bv.runs > 50 && bv.runs < 100
			b_points  = b_points + 50 if bv.runs > 100
		end
		if bov.present?
			wik_points = 0 if bov.wickets == 0
			wik_points = 20 if bov.wickets == 1
			wik_points = 30 if bov.wickets >= 2
			bo_points = (wik_points * bov.wickets) + (bov.zeros * 1) + (((bov.overs * 9) - bov.runs) * 2) + (bov.maidens * 25)
		end
		if fv.present?
			f_points = fv.runout * 15 + fv.stumped * 15 + fv.catch * 15
		end
		total_score = b_points + bo_points + f_points
		@score = MyScore.where(user_id: user.id, match_id: match_id).find_by(pid: self.pid)

		if @score.present?
			 if @score.changed?
				 @score.update(batting_score: b_points,  
					bowling_score: bo_points, 
					fielding_score: f_points, 
					total_score: total_score,
				)
			end
		else
			@score = MyScore.create(batting_score: b_points,  
				bowling_score: bo_points, 
				fielding_score: f_points, 
				total_score: total_score,
				user_id: user.id,
				player_name: player,
				match_id: match_id,
				pid: self.pid
				)
		end
		@scores = MyScore.where(user_id: user.id, match_id: match_id)
		if @scores.present?
			gained_score = @scores.sum(&:total_score) 
			# binding.pry
			# self.match.update(total_score: gained_score) if gained_score.present? 
		end
		match.set_rank(user)
		return total_score
	end

	def get_e_points(user)
		if self.my_scores.present?
			if self.my_scores.find_by(user_id: user.id).present?
				self.my_scores.find_by(user_id: user.id).total_score
			else
				'--'
			end
		end
	end



end
