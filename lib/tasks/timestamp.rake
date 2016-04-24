namespace :timestamp do
	desc "show timezones of time related objects"
	task show: :environment do
		puts "System time zone: #{Timestamp.system_zone}"
		puts "Rails' time zone: #{Timestamp.rails_zone}"
		%w(Time.now).each do |str|
			ts = Timestamp.evaluate(str)
			puts ts
		end
	end
end