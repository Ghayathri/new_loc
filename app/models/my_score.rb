class MyScore < ApplicationRecord

	belongs_to :user
	belongs_to :match

	def self.get_total_points(user, match_id)
		@scores =  MyScore.where(user_id: user.id, match_id: match_id)
		if @scores.present?
			total = @scores.sum(&:total_score)
		else
			'--'
		end
	end

	def self.get_total_rank(user, match_id)
		@scores =  self.where(user_id: user.id, match_id: match_id)
  	if @scores.present?
	  	sorted = @scores.order('total_score DESC')
	  	@ranking_results = sorted.map{|e| [e,sorted.index(e) + 1] }
	  	@ranking_results.each do |score,rank|
				score.update(ranking: rank)
			end
		end
		@scores.last.ranking
	end

end
