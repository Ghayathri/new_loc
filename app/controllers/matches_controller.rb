class MatchesController < ApplicationController
	before_action :authenticate_user!
	def index
		@matches = Match.published
	end
end
