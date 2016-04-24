namespace :timestamp do
	desc "show timezones of time related objects"
	task show: :environment do
		%w(Time.now).each do |str|
			ts = Timestamp.evaluate(str)
			puts ts
		end
	end
end
