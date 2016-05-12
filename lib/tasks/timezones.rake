namespace :timezones do
	namespace :sys do
		desc "move aroud system timezones"
		task travel: :environment do
			Timecop.freeze(Time.new(1993, 2, 24, 12, 0, 0, "+09:00"))
			original = Time.now.strftime("%H:%M %Z")
			threads = Array.new
			errors = Array.new
			puts "Traveling time ..."
			10000.times do
				{
					'HST' => '17:00',
					'EST' => '22:00',
					'UTC' => '03:00',
					'CET' => '04:00',
					'Japan' => '12:00',
				}.each_pair do |tz, target|
					threads << Thread.new do
						ENV['TZ'] = tz
						converted = Time.now.strftime("%H:%M")
						if target != converted
							errors << "#{original} became #{converted} in #{tz} (shuold be #{target})"
						end
					end
				end
			end
			threads.each{|th| th.join}
			unless errors.empty?
				puts errors.join("\n")
			else
				puts "Complete time travel"
			end
		end
	end
end
