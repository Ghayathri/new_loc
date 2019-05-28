class LiveController < ApplicationController

		before_action :load_match

		def load_match
			@match = Match.find_by_id(params[:match_id])
		end

		def index
			@squad = @match.user_squad(current_user.id)
			@players = @match.teams.where(id: @squad.player_ids)
			CricApi.fantasy_summary(@match.id)
		end

			def move_to_live
				@matches = Match.published
				@match.update(match_started: true)
				respond_to do |format|
					format.js {render 'move_to_live'}
				end
			end

end
