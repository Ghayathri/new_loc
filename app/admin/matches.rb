ActiveAdmin.register Match do

	config.filters = false
	config.batch_actions = false
	actions :index, :show
	config.sort_order = 'id_asc'

	# scope :match_started, -> {where(match_started: true)}
	# scope :team_ready, -> {where(squad: true)}
	scope :twenties, -> { where(test_type: 'Twenty20') }

	action_item :super_action, only: :index do
  	link_to "Update New Match", update_matches_path, method: :post
  end

 	show :title => proc{|match| match.team_2 + " vs " + match.team_1} do
     render 'match_result'
  end

  action_item :super_action, only: :show do
  	# if match.match_started?
  		link_to "Update Match Result", match_summary_path(id: match.id), method: :post
  	# end
  end

  action_item :super_action, only: :show do
  	if  match.squad? && !match.publish?
  		link_to "Publish", publish_path(id: match.id), method: :get
  	end
  end

  index do
  	column "Match ID" do |match|
    	link_to match.unique_id
  	end
  	column :team_1
  	column :team_2
  	column :test_type
  	column :match_time
  	column :squad
  	column :toss_wt
  	column :winner_team
  	column :match_started
  	column :actions do |match|
        links = []
        links << link_to('Show', admin_match_path(match))
        if match.match_started?
          links << link_to('Results', match_summary_path(match), method: :post)
        end
        if !match.match_started? && match.squad? && !match.publish? && !match.teams.present?
        	links << link_to('Squad', create_squad_path(match), method: :post)
        end
        links.join(' ').html_safe
      end
  end

  controller do

  	  def scoped_collection
      	@matches = Match.all.twenties
    	end

  		def update_matches
  			url = "http://cricapi.com/api/matches?apikey=WJECv6admYcdFNGafb1R2uamPp43"
    		begin
    			response = HTTParty.get(url)
    			parser = Yajl::Parser.new
    			hash = parser.parse(response.body)
    			hash["matches"].each do |match|
            @match = Match.find_by(unique_id: match["unique_id"])
            unless @match.present?
      				Match.find_or_create_by(
      					unique_id: match["unique_id"],
    						team_2: match["team-2"],
    						team_1: match["team-1"],
    						test_type: match["type"],
    						match_time: match["dateTimeGMT"],
    						squad: match["squad"],
    						toss_wt: match["toss_winner_team"],
    						winner_team: match["winner_team"],
    						match_started: match["matchStarted"],
      				)
      			else
      				@match.update!(match_time: match["dateTimeGMT"],
    						squad: match["squad"],
    						toss_wt: match["toss_winner_team"],
    						winner_team: match["winner_team"],
    						match_started: match["matchStarted"])
            end
    			end
    			flash["success"] = "Successfully updated"
    			redirect_to admin_matches_path
    		rescue Exception => e
    			flash["error"] = "Please try again later"
    			redirect_to admin_matches_path
    		end
  		end

  		def match_summary
	   		CricApi.fantasy_summary(params[:id])
	   		redirect_to admin_matches_path
  		end

  		def create_squad
  			CricApi.get_team(params[:id])
  			redirect_to admin_matches_path
  		end

  		def publish
  			@match = Match.find(params[:id])
  		end

  		def finish_setup
  			@match = Match.find(params[:id])
  			if @match.update_attributes(team_params)
					flash[:success] = "Successfully Updated"
					@match.update!(publish: true)
					respond_to do |format|
						format.html{redirect_to admin_matches_path}
					end
				end
  		end

  		private

  		def team_params
  			params.require(:match).permit(:teams_attributes => [:id, :points])
  		end

  end

end
