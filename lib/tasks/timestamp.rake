namespace :timestamp do
	desc "show timezones of time related objects"
	task show: :environment do
		Timecop.freeze(Time.new(1993, 2, 24, 12, 0, 0, "+09:00"))
		# Ruby's birthday
		puts "System timezone: #{Timestamp.system_zone}"
		puts "Rails' timezone: #{Timestamp.rails_zone}"
		%w(
			Time.now
			Date.yesterday
			Date.today
			Date.tomorrow
			DateTime.current
			DateTime.now
			Time.zone.now
			Time.now.in_time_zone
		).each do |str|
			ts = Timestamp.evaluate(str)
			puts ts
		end
	end

	desc "Time Travel as a Service"
	task ttaas: :environment do
		puts "System timezone: #{Timestamp.system_zone}"
		puts "Rails' timezone: #{Timestamp.rails_zone}"
		Timecop.freeze(Time.new(2016, 4, 11, 18, 59, 0, "-07:00"))
		[
			'Date.today == Date.tomorrow',
			'Date.today',
			'Date.yesterday'
		].each do |cmd|
			puts "> #{cmd}"
			puts "=> #{eval(cmd)}"
		end
		puts "WAT"
		%w(
			Time.now
			Time.zone.now
			Date.yesterday
			Date.today
			Date.tomorrow
			Time.zone.yesterday
			Time.zone.today
			Time.zone.tomorrow
		).each do |str|
			ts = Timestamp.evaluate(str)
			puts ts
		end
	end
end
