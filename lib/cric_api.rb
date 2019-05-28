class CricApi

	def self.fantasy_summary(match_id)
		@match = Match.find(match_id)
    url = "http://cricapi.com/api/fantasySummary?unique_id=#{@match.unique_id}&apikey=WJECv6admYcdFNGafb1R2uamPp43"
    response = HTTParty.get(url)
    parser = Yajl::Parser.new
    hash = parser.parse(response.body)
    @data = hash["data"]
    begin
      
    	@data["fielding"].each do |field|
        field["scores"].each do |score|
        	if @match.fieldings.present? && @match.fieldings.find_by(fielder: score["name"]).present?
        		@fields = @match.fieldings.find_by(fielder: score["name"])
        		@fields.update!(runout: score["runout"],
            stumped: score["stumped"], bowled: score["bowled"],lbw: score ["lbw"],
            catch: score["catch"], team_name: field["title"])
        	else
            @fields = @match.fieldings.create(
              fielder: score["name"], runout: score["runout"],
              stumped: score["stumped"], bowled: score["bowled"],lbw: score ["lbw"],
              catch: score["catch"], team_name: field["title"], pid: score["pid"]
              )
            @fields.save
          end
        end
      end

      
      	@data["bowling"].each do |field|
          field["scores"].each do |score|
          	if @match.bowlings.present? && @match.bowlings.find_by(bowler: score["bowler"]).present?
          		@fields = @match.bowlings.find_by(bowler: score["bowler"]) 
          		@fields.update!(sixs: score["6s"],fours: score["4s"],zeros: score["0s"], overs: score["O"], 
              wickets: score["W"], runs: score["R"],maidens: score["M"],
              team_name: field["title"], econ: score["Econ"])
          	else
							@fields = @match.bowlings.create(
                sixs: score["6s"],fours: score["4s"],zeros: score["0s"], overs: score["O"], 
                wickets: score["W"], runs: score["R"],maidens: score["M"], bowler: score["bowler"],
                team_name: field["title"], econ: score["Econ"], pid: score["pid"]
                )
							@fields.save
						end
          end
        end

      
      	@data["batting"].each do |field|
          field["scores"].each do |score|
          	if score["batsman"] == "Extras"
        			if @match.match_extras.present? && @match.match_extras.find_by(team_name: field["title"])
          			@extras = @match.match_extras.find_by(team_name: field["title"])
          			@extras.update!(details: score["detail"])
          		else
          			@extras = @match.match_extras.create(team_name: field["title"], details: score["detail"])
          			@extras.save
          		end
          	else
            	if @match.battings.present? && @match.battings.find_by(batsman: score["batsman"]).present?
              		@fields = @match.battings.find_by(batsman: score["batsman"])
              		@fields.update!(dismissal: score["dismissal"], strike_rate: score["SR"], sixes: score["6s"],
	                fours: score["4s"], balls_played: score["B"],
	                runs: score["R"], dismissal_info: score["dismissal-info"], team_name: field["title"])
            	else
                @fields = @match.battings.create(
                dismissal: score["dismissal"], strike_rate: score["SR"], sixes: score["6s"],
                fours: score["4s"], balls_played: score["B"],
                runs: score["R"], dismissal_info: score["dismissal-info"],
                batsman: score["batsman"], team_name: field["title"], pid: score["pid"]
                )
              	@fields.save	
              end
            end
          end
        end

        if !@match.teams.present?
	     		CricApi.get_team(match_id)
	      end

        if @data["winner_team"].present?
        	@match.update(winner_team: @data["winner_team"], 
        		man_of_the_match: @data["man-of-the-match"]["name"],
        		match_ended: true)
        end

        @match.calculate_total_score
		rescue Exception => e
    end
	end

	def self.get_team(match_id)
		@match = Match.find(match_id)
    if !@match.teams.present?
			url = "http://cricapi.com/api/fantasySquad?apikey=WJECv6admYcdFNGafb1R2uamPp43&unique_id=#{@match.unique_id}"
			response = HTTParty.get(url)
  		parser = Yajl::Parser.new
  		hash = parser.parse(response.body)
  		@data = hash["squad"]
  		@data.each do |team|
  			team["players"].each do |players|
  				@match.teams.create(player: players["name"], team_name: team["name"], pid: players["pid"])
  			end
  		end
    end
	end

end
