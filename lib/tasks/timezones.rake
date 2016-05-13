module TimeZones
	def self.travel(&block)
		Timecop.freeze(Time.new(1993, 2, 24, 12, 0, 0, "+09:00"))
		original = yield(nil).strftime("%H:%M %Z")
		threads = Array.new
		errors = Array.new
		print "Traveling time ..."
		mutex = Mutex.new
		10000.times do
			{
				'HST' => '17:00',
				'EST' => '22:00',
				'UTC' => '03:00',
				'CET' => '04:00',
				'Japan' => '12:00',
			}.each_pair do |tz, target|
				threads << Thread.new do
					converted = yield(tz).strftime("%H:%M")
					if target != converted
						mutex.synchronize do
							errors << "#{original} became #{converted} in #{tz} (shuold be #{target})"
							print '!'
						end
					end
				end
			end
		end
		threads.each{|th| th.join}
		unless errors.empty?
			puts "\n" + errors.join("\n")
		else
			puts "\ncompleted time travel"
		end
	end
end

namespace :timezones do
	namespace :sys do
		desc "move aroud system timezones"
		task travel: :environment do
			TimeZones.travel{|tz| ENV['TZ'] = tz if tz; Time.now }
		end
	end

	namespace :rails do
		desc "move aroud system timezones"
		task travel: :environment do
			TimeZones.travel{|tz| tz ? Time.now.in_time_zone(tz) : Time.zone.now }
		end
	end
end
