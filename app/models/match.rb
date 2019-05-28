class Match < ApplicationRecord

	include LiveHelper

	# Relations
	has_many :fieldings
	has_many :battings
	has_many :bowlings
	has_many :squads
	has_many :teams
	has_many :match_extras
	has_many :my_scores

	scope :match_started, -> {where(match_started: true)}
	scope :team_ready, -> {where(squad: true)}
	scope :twenties, -> { where(test_type: 'Twenty20') }
	scope :published, -> { where(publish: true) }

	accepts_nested_attributes_for :teams, allow_destroy: true

	def my_squads(user)
		self.squads.find_by_user_id(user.id) if self.squads.present?
	end

	def calculate_total_score
		if self.battings.present?
			self.battings.group_by(&:team_name).each do |team_name, battings|
				runs = battings.sum(&:runs)
				@extra = self.match_extras.find_by(team_name: team_name)
				runs = runs + @extra.details[0..1].to_i if @extra.present?
				@extra.update(total_runs: runs)
			end
		end
	end

	def match_title
		self.team_1 + " vs " + self.team_2
	end

	def user_squad(user_id)
		if squads.present?
			self.squads.find_by(user_id: user_id)
		end
	end

	def started?
    return true if self.match_time < current_time_zone
    return false
  end

  def get_total_score(user_id)
  	if self.my_scores.present?
  		self.my_scores.sum(&:total_score)
  	end
  end

  def set_rank(user)
  	@scores = self.my_scores.where(user_id: user.id)
  	if @scores.present?
	  	sorted = @scores.order('total_score DESC')
	  	@ranking_results = sorted.map{|e| [e,sorted.index(e) + 1] }
	  	@ranking_results.each do |score,rank|
				score.update(ranking: rank)
			end
		end
  end

end
