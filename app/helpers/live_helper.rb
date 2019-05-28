module LiveHelper

		def current_time_zone
		  DateTime.now
		end

		def count_down_timer_server(date_time)
			date_time.in_time_zone(get_time_zone).strftime("%a %b %-d %Y %H:%M:%S") if date_time.present?
		end

		def count_down_timer_server(date_time)
    	date_time.in_time_zone(get_time_zone).strftime("%a %b %-d %Y %H:%M:%S") if date_time.present?
 		end

end
