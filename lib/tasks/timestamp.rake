namespace :timestamp do
	desc "show timezones of time related objects"
	task show: :environment do
		Timecop.freeze(Time.new(1993, 2, 24, 12, 0, 0, "+09:00"))
		# Ruby's birthday
		puts "System timezone: #{Timestamp.system_zone}"
		puts "Rails' timezone: #{Timestamp.rails_zone}"
		%w(
			Time.now
			Date.today
			DateTime.current
			DateTime.now
			Time.zone.now
			Time.now.in_time_zone
		).each do |str|
			ts = Timestamp.evaluate(str)
			puts ts
		end
	end
end
