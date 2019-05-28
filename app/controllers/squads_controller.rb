class SquadsController < ApplicationController
	before_action :authenticate_user!

	before_action :load_match

	def load_match
		@match = Match.find_by_id(params[:match_id])
	end

	def index
		@squads = current_user.squads
	end

	def new
		@squad = Squad.new
	end

	def create
		params[:squad][:player_ids] = params[:squad][:player_ids].split(",").map(&:to_i)
		@squad = Squad.new(squad_params)
		if @squad.save
			redirect_to squad_path(@squad)
		else
			render 'new'
		end
		# respond_to do |format|
  #     format.html { redirect_to matchs_path }
  #     format.js
  #   end
	end

	def show
		@squad = Squad.find_by_id(params[:id])
	end


	def edit
		@squad = Squad.find_by_id(params[:id])
		@match = @squad.match
	end

	def update
		if @squad.update(squad_params)
		 redirect_to squad_path(@squad)
		else
			render 'edit'
		end
	end


	private 

	def squad_params
		params.require(:squad).permit(:user_id ,:match_id, :player_ids => [])
	end


end
