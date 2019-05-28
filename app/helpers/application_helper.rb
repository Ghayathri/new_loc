module ApplicationHelper

	 def get_time_zone
    # if current_user.present?
    #   current_user.time_zone
    # else
      if cookies['time_zone_offset'].nil?
        "America/Los_Angeles"
      else
        cookies['time_zone_offset']
      end
    # end
  end

  def get_offset
    # if current_user.present?
    #   Time.now.in_time_zone(current_user.time_zone).utc_offset/60/60
    # else
      if cookies['time_zone_offset_number'].nil?
        "+8"
      else
        cookies['time_zone_offset_number']
      end
    # end
  end

	def match_time_display(date_time)
		date_time.in_time_zone(get_time_zone).strftime('%m/%d/%Y, %I:%M %p %Z') if date_time.present?
	end

end
